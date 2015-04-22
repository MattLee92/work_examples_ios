//
//  PhotoCollectionTests.swift
//  PhotoCollectionTests
//
//  Created by Matthew Lee on 19/04/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit
import XCTest

class PhotoCollectionTests: XCTestCase {
    
    //Test Setters and getters for Photo Class
    func testPhoto(){
        let myphoto = Photo(title: "SomeTitle", tags: ["sometag", "gu", "Griffith"], url: "http://www.griffith.edu.au/__data/assets/image/0019/632332/gu-header-logo.png")
        XCTAssertEqual(myphoto.title, "SomeTitle")
        XCTAssertEqual(myphoto.tags, ["sometag", "gu", "Griffith"])
        XCTAssertEqual(myphoto.url, "http://www.griffith.edu.au/__data/assets/image/0019/632332/gu-header-logo.png")
        
    }
    
    //Test adding to an empty array (Beginning and End of Array)
    func testEmptyArray(){
        let mytags = Photo(title: "SomeTitle", tags: [], url: "www.someurl.com.au")
        //Append first value
        mytags.tags.append("First Value")
        //Insert begginging value at index 0
        mytags.tags.insert("Insert Begining",atIndex: 0)
        let count = mytags.tags.count
        //Insert end value to the value of array.count
        mytags.tags.insert("Insert End", atIndex: count)
        //Expected array to match  to
        let expected = ["Insert Begining", "First Value", "Insert End"]
        XCTAssertEqual(expected[0],mytags.tags[0])
        XCTAssertEqual(expected[1],mytags.tags[1])
        XCTAssertEqual(expected[2],mytags.tags[2])
        
        
    }
    
    //Test adding to non-empty Array (Beggining middle and end)
    func testNonEmptyArray(){
        //Initial array elements
        let mytags = Photo(title: "SomeTitle", tags: ["First", "Second"], url: "www.someurl.com.au")
        // declare varialble to keep count of elelments
        var count = mytags.tags.count
        //insert first element at index 0
        mytags.tags.insert("Insert First",atIndex: 0)
        //Update count
        count = mytags.tags.count
        //Insert last element at end of array (count of elements)
        mytags.tags.insert("Insert Last",atIndex: count)
        //Update count
        count = mytags.tags.count
        // If half of count can be computed as an integer insert middle value to that integer
         let middle = count / 2
            mytags.tags.insert("Insert Middle",atIndex: middle)
        
        //Expected array to match to
        let expected = ["Insert First", "First", "Insert Middle", "Second", "Insert Last"]
        XCTAssertEqual(expected[0], mytags.tags[0])
        XCTAssertEqual(expected[1], mytags.tags[1])
        XCTAssertEqual(expected[2], mytags.tags[2])
        XCTAssertEqual(expected[3], mytags.tags[3])
        XCTAssertEqual(expected[4], mytags.tags[4])
        
    }
    
    //Test background download of image from url
    func testDowloadAsync() {
        //Set mainQueue to a low priority backgroung queue
        mainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        //set myphoto with test values
        let myphoto = Photo(title: "SomeTitle", tags: ["sometag", "gu", "Griffith"], url: "http://www.griffith.edu.au/__data/assets/image/0019/632332/gu-header-logo.png")
        //variable to determine if download is complete
        var downloadcomplete = false
        //Call loadimage function from Photo class
        myphoto.loadimage { data in
            downloadcomplete = true
        }
        //Set max wait time for download
        var maxWait = 10
        
        //Loop until download complete or timeout (10 seconds)
        while !downloadcomplete && maxWait-- > 0 {
            sleep(1)
        }
        //Assert download was succesfull
        XCTAssertNotNil(myphoto.data, "Could not Download")
        XCTAssertNotNil(UIImage(data: myphoto.data!), "Not an Image")
        
    }
    
    //Test Save Photo to file
    func testSavePhoto(){
        //Set Test Photo
        let myphoto = Photo(title: "Sometitle", tags: ["tag1", "tag2"], url: "www.someurl.com.au")
        // Assign pl the property list from Photo class
        let pl = myphoto.propertyList()
        //Set the path and filename of the file to write to
        let dirs = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filename = dirs + "/testData.plist"
        //Assert that the data was written to the file
        XCTAssertTrue(pl.writeToFile(filename,atomically: true), "Could Not Write to File")
    }
    
    //Test load from File
    func testLoadPhoto(){
        //Get the path and filename to read from
        let dirs = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filename = dirs + "/testData.plist"
        // Set pl2 to the contents of the file
        let pl2 = NSArray(contentsOfFile: filename)
        //Assert that pl2 is not nil thus file was read from
        XCTAssertNotNil(pl2, "Could not Read from File")
    }
    
    
    
    
    
    
    
    
    
    
}
