//
//  Photo.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {

    struct URL {
        let square: NSURL
        let large: NSURL
    }

    let url: URL
    let title: String

}

extension Photo: NetworkResponseType {

    init?(json: JSON) {
        if
            let title = json["title"].string,
            let square = json["url_sq"].string,
            let large = json["url_l"].string,
            let squareURL = NSURL(string: square),
            let largeURL = NSURL(string: large)
        {
            self.title = title
            self.url = URL(square: squareURL, large: largeURL)
        }
        else {
            return nil
        }
    }

}

struct PhotoCollection: NetworkResponseType {

    let photos: [Photo]

    init?(json: JSON) {
        var photos: [Photo] = []
        if let array = json["photos"]["photo"].array {
            for pjson in array {
                if let photo = Photo(json: pjson) {
                    photos.append(photo)
                }
            }
            self.photos = photos
        } else {
            return nil
        }
    }

}