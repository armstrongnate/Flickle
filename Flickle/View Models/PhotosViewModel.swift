//
//  PhotosViewModel.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation

class PhotosViewModel {

    let photos: [Photo]
    let query: String

    init(query: String, photos: [Photo]) {
        self.query = query
        self.photos = photos
    }

    func photoViewModel(indexPath: NSIndexPath) -> PhotoViewModel {
        return PhotoViewModel(photo: photos[indexPath.row])
    }

}