//
//  Photo.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Student ID: s2818045
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import Foundation

class Photo {
    // Varialbes of Photo
    var title: String
    var tags: [String]
    var url: String
    var data: NSData?
    
    //Initialise variables
    init(title: String, tags: [String], url: String){
        self.title = title
        self.tags = tags
        self.url = url
    
    }
    
    //Downloads data from given URL and converts to image
    func loadimage(completionhandler: (data: NSData?) -> Void) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        dispatch_async(queue) {
            let mainQueue = dispatch_get_main_queue()
            if let url = NSURL(string: self.url){
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(mainQueue){
                    self.data = data
                    completionhandler(data: data)
                    }
                    return
                }
            }
            dispatch_async(mainQueue){
                completionhandler(data: nil)
            }
        }
    }
    
}
