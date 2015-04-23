//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Student ID: s2818045
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"



class PhotosCollectionViewController: UICollectionViewController, DetailViewControllerDelegate  {

    //Variables for Photos
    var photos = Array<Photo>()
    var currentPhoto: Photo!
    var currentIndex: Int!
    var deletePhoto: Bool = false

    
    override func viewDidAppear(animated: Bool) {
        if deletePhoto == true {
            DeletePhoto()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

      
        
        // Set photos array to the contents of the file
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let filename = ("\(dir)/data.plist")
        
        if let loadedphoto = NSArray(contentsOfFile: filename){
            photos = loadedphoto as Array
        }
        
        // Register cell classes
        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }
    
    //Adds a new 'empty' instance of photo and saves it to the photos array
    //segues to detail for for user to enter data
    @IBAction func AddPhoto(sender: AnyObject) {
        currentPhoto = Photo(title: "", tags: [], url: "")
        photos.append(currentPhoto)
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    private func DeletePhoto(){
        
            photos.removeAtIndex(currentIndex)
            collectionView?.reloadData()
            // Write changes to file??
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       //Pass current photo to the Detailviewcontroller via the Delegate
        if let dvc = segue.destinationViewController as? DetailViewController {
            dvc.photo = currentPhoto
            dvc.delegate = self
        }
    }
    
    func detailViewController(dvc: DetailViewController, photo: Photo, del: Bool){
       navigationController?.popToViewController(self, animated: true)
           collectionView?.reloadData()
            deletePhoto = del
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

    //Set the image for the Cells of the Collection view
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
        currentIndex = indexPath.row
        self.performSegueWithIdentifier("ShowDetail", sender: self)
       
        return true
      
    }
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
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
