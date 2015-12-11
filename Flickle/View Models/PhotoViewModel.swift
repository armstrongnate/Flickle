//
//  PhotoViewModel.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation
import ReactiveCocoa

class PhotoViewModel {

    let photo: MutableProperty<Photo>

    init(photo: Photo) {
        self.photo = MutableProperty<Photo>(photo)
    }

}