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
        XCTAssertEqual(myphoto.title, "http://www.griffith.edu.au/__data/assets/image/0019/632332/gu-header-logo.png")
        
    }
    
    //Test adding to an empty array (Beginning and End of Array)
    func testEmptyArray(){
        let mytags = Photo.tags[]
        //Append first value
        mytags.append("First Value")
        //Insert begginging value at index 0
        mytags.insert("Insert Beginning",0)
        let count = mytags.count
        //Insert end value to the value of array.count
        mytags.insert("Insert End", count)
        //Expected array to match  to
        let expected = ["Insert Beggining", "First Value", "Insert End"]
        XCTAssertEqual(expected[0],mytags[0])
        XCTAssertEqual(expected[1],mytags[1])
        XCTAssertEqual(expected[2],mytags[2])
        
        
    }
    
    //Test adding to non-empty Array (Beggining middle and end)
    func testNonEmptyArray(){
        //Initial array elements
        let mytags = Photo.tags["First", "Second"]
        // declare varialble to keep count of elelments
        var count = mytags.count
        //insert first element at index 0
        mytags.insert("Insert First",0)
        //Update count
        count = mytags.count
        //Insert last element at end of array (count of elements)
        mytags.insert("Insert Last",count)
        //Update count
        count = mytags.count
        // If half of count can be computed as an integer insert middle value to that integer
        if let middle = count/2 {
            mytags.insert("Insert Middle",middle)
        }
        //Expected array to match to
        let expected = ["Insert First", "First", "Insert Middle", "Second", "Insert Last"]
        XCTAssertEqual(expected[0], mytags[0])
        XCTAssertEqual(expected[1], mytags[1])
        XCTAssertEqual(expected[2], mytags[2])
        XCTAssertEqual(expected[3], mytags[3])
        XCTAssertEqual(expected[4], mytags[4])
        
    }
    
}
