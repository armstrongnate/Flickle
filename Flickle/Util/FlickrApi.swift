//
//  FlickrApi.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation
import BrightFutures

enum ApiError: ErrorType {
    case Any
}

class FlickrApi {

    let apiKey: String
    private let networkController: NetworkController

    init(networkController: NetworkController, apiKey: String) {
        self.networkController = networkController
        self.apiKey = apiKey
    }

    func search(query: String, perPage: UInt) -> Future<[Photo], ApiError> {
        let promise = Promise<[Photo], ApiError>()

        let params: [String:String] = [
            "api_key": apiKey,
            "method": "flickr.photos.search",
            "text": query,
            "extras": "url_sq,url_l,owner_name",
            "format": "json",
            "nojsoncallback": "1",
            "per_page": "\(perPage)"
        ]

        networkController.get("/", params: params)
            .onSuccess { (collection: PhotoCollection) in
                return promise.success(collection.photos)
            }
            .onFailure { error in
                return promise.failure(ApiError.Any)
            }

        return promise.future
    }

}