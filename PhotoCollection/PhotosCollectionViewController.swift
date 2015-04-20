//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController, DetailViewControllerDelegate  {

    var photos = Array<Photo>()
    var currentPhoto: Photo!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddPhoto(sender: AnyObject) {
        
        currentPhoto = Photo(title: "", tags: [], url: "")
        photos.append(currentPhoto)
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     /*
        if let cell = sender as? PhotoCollectionViewCell {
         let indexPath = collectionView?.indexPathForCell(cell)!
            currentPhoto = photos[indexPath!.row]
           println("SELECTED")
       } else {
           println("ERROR")
         
       } */
        if let dvc = segue.destinationViewController as? DetailViewController {
            dvc.photo = currentPhoto
            dvc.delegate = self
            
        }
        
        
    }
    
    func detailViewController(dvc: DetailViewController, photo: Photo){
        navigationController?.popToViewController(self, animated: true)
            collectionView?.reloadData()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as PhotoCollectionViewCell
    
        let photo = photos[indexPath.row]
        if let d = photo.data {
            let image = UIImage(data: d)
            cell.imageView.image = image
        } else {
            photo.loadimage {
                if $0 != nil {
                    collectionView.reloadItemsAtIndexPaths([indexPath])
                }
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        currentPhoto = photos[indexPath.row]
        self.performSegueWithIdentifier("ShowDetail", sender: self)
        return true
    }
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
