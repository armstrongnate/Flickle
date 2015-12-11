//
//  SearchViewModel.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import Foundation
import ReactiveCocoa
import BrightFutures

class SearchViewModel {

    let api: FlickrApi
    let isSearching = MutableProperty<Bool>(false)
    let query = MutableProperty<String>("")
    private var photos: [Photo] = []

    init(api: FlickrApi) {
        self.api = api
    }

    func search() -> Future<[Photo], ApiError> {
        isSearching.value = true
        let promise = Promise<[Photo], ApiError>()

        api.search(query.value, perPage: 25)
            .onSuccess { (photos: [Photo]) in
                self.photos = photos
                return promise.success(photos)
            }
            .onFailure { error in
                return promise.failure(error)
            }
            .onComplete { [weak self] _ in
                self?.isSearching.value = false
            }

        return promise.future
    }

    func photosViewModel() -> PhotosViewModel {
        return PhotosViewModel(query: query.value, photos: photos)
    }

}