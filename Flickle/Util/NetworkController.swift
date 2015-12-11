//
//  NetworkController.swift
//
//  Created by Nate Armstrong on 11/11/15.
//

import Alamofire
import BrightFutures
import SwiftyJSON

public protocol NetworkResponseType {
    init?(json: JSON)
}

public protocol NetworkParameter {
    func parameterize() -> [String:String]
}

public enum NetworkError: Int, ErrorType {
    case BadRequest = 404
    case ParseError = 1000
}

public class NetworkController {

    // MARK: Types

    public typealias Method = Alamofire.Method

    public struct Authentication {
        let username: String
        let password: String

        public init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }

    // MARK: Properties

    let baseURL: String

    // MARK: Initializers

    public init(baseURL: String) {
        self.baseURL = baseURL
    }

    // MARK: Instance Methods

    public func get<T: NetworkResponseType>(path: String, params: [String:String]? = nil, authentication: Authentication? = nil) -> Future<T, NetworkError> {
        return sendRequest(.GET, path: path, key: nil, params: params, authentication: authentication)
    }

    public func post<T: NetworkResponseType>(path: String, _ key: String, params: [String: String], authentication: Authentication? = nil) -> Future<T, NetworkError> {
        return sendRequest(.POST, path: path, key: key, params: params, authentication: authentication)
    }

    public func post<T: NetworkResponseType>(path: String, _ key: String, param: NetworkParameter, authentication: Authentication? = nil) -> Future<T, NetworkError> {
        return sendRequest(.POST, path: path, key: key, params: param.parameterize(), authentication: authentication)
    }

    func sendRequest<T: NetworkResponseType>(method: Method, path: String, key: String?, params: [String:String]?, authentication: Authentication?) -> Future<T, NetworkError> {
        let promise = Promise<T, NetworkError>()

        // parameters
        let parameters = params ?? [String:String]()

        // setup request
        var request = Alamofire.request(method, "\(baseURL)\(path)", parameters: parameters)

        // basic auth
        if let auth = authentication {
            request = request.authenticate(user: auth.username, password: auth.password)
        }

        // send request
        request.responseData { response in
            if
                let data = response.result.value,
                let t = T(json: JSON(data: data)),
                let res = response.response
                where response.result.isSuccess && res.statusCode == 200
            {
                promise.success(t)
            }
            else {
                promise.failure(.BadRequest)
            }
        }
        
        return promise.future
    }
}
