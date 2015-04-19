//
//  Photo.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import Foundation

class Photo {
    var title: String
    var tags: [String]
    var url: String
    
    init(title: String, tags: [String], url: String){
        self.title = title
        self.tags = tags
        self.url = url
    }
    
}