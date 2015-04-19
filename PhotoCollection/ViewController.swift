//
//  ViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var photo: Photo! = Photo(title: "", tags: [], url: "")
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let urlString = textField.text
        photo.url = urlString
        let conToImage: (NSData?) -> Void = {
            if let d = $0 {
                let image = UIImage(data: d)
                self.imageview.image=image
            } else {
                self.imageview.image=nil
            }
            textField.resignFirstResponder()
        }
            if let d = photo.data {
               conToImage(d)
            } else {
                photo.loadimage(conToImage)
            }
        
    
            return true
        }
    

    
    

}

