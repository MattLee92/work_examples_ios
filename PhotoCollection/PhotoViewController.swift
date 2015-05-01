//
//  PhotoViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 1/05/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

//Delegate protocol for PhotoViewController
protocol PhotoViewControllerDelegate{
    func photoViewController(dvc: PhotoViewController, photo: Photo)
}


class PhotoViewController: UIViewController, DetailViewControllerDelegate {

    //Variables for PhotoView
    var delegate: PhotoViewControllerDelegate!
    var photo: Photo!
    
    //ImageView outlet
    @IBOutlet weak var imageview: UIImageView!
    

    override func viewDidLoad() {
        //Hide navigation bars
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        super.viewDidLoad()
        
        //Get the photo to display from URL
        let urlString = photo.url
        let conToImage: (NSData?) -> Void = {
            if let d = $0 {
                let image = UIImage(data: d)
                self.imageview.image=image
            } else {
                self.imageview.image=nil
            }
           
        }
        if let d = photo.data {
            conToImage(d)
        } else {
            photo.loadimage(conToImage)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if the destination view is the detail view controller then pass the current photo and set the delegate 
        if let dvc = segue.destinationViewController as? DetailViewController {
            dvc.photo = photo
            dvc.delegate = self
        }
    }
    

    func detailViewController(dvc: DetailViewController, photo: Photo) {
        navigationController?.popToViewController(self, animated: true)
        
    }
}
