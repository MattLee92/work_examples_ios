//
//  PhotoViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 1/05/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

protocol PhotoViewControllerDelegate{
    func photoViewController(dvc: PhotoViewController, photo: Photo)
}


class PhotoViewController: UIViewController, DetailViewControllerDelegate {

    var delegate: PhotoViewControllerDelegate!
    var photo: Photo!
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? DetailViewController {
            dvc.photo = photo
            dvc.delegate = self
        }
    }
    

    func detailViewController(dvc: DetailViewController, photo: Photo) {
        navigationController?.popToViewController(self, animated: true)
        
    }
}
