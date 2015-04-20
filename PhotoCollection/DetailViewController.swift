//
//  ViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Student ID: S2818045
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate{
    func detailViewController(dvc: DetailViewController, photo: Photo)
}

class DetailViewController: UIViewController, UITextFieldDelegate {

    var delegate: DetailViewControllerDelegate!
    var photo: Photo!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var txt_tags: UITextField!
    @IBOutlet weak var txt_url: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Updates current photo with edits the user has entered in the text feilds (if all feilds are entered)
    @IBAction func AddPhoto(sender: AnyObject) {
        if let title = txt_title.text {
            if let tags = txt_tags.text {
                if let url = txt_url.text{
                    photo.title = title
                    photo.tags.append(tags)
                    photo.url = url
                    photo.data = nil
                    delegate.detailViewController(self, photo: photo)
                }
            }
        }
    }
    
    //Function to retrive image from photo.data or download image as appropriate
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
    
    //Populates detail view with data from Photo if the user has selected a previous entry
    override func viewWillAppear(animated: Bool) {
        txt_title.text = photo.title
        //Condition to stop reading non-existing elements from an empty array
        if photo.tags.count != 0 {
            txt_tags.text = photo.tags[0]
        }
        txt_url.text = photo.url
        photo.data = nil
    }
    
    

}

