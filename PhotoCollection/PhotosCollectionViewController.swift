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



class PhotosCollectionViewController: UICollectionViewController, DetailViewControllerDelegate, PhotoViewControllerDelegate  {

    //Variables for Photos
    var photos = Array<Photo>()
    var currentPhoto: Photo!
    var currentIndex: Int!

    
    @IBAction func unwindDel(segue: UIStoryboardSegue){
        DeletePhoto()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue){
      
    }
    
    
    override func viewDidAppear(animated: Bool) {
       SaveToFile()
       
    }
    //This method calls the function to load data from file (persistance)
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadFromFile()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Set photos array to the contents of the file
        // Register cell classes
        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }
    
    //Adds a new 'empty' instance of photo and saves it to the photos array
    //segues to detail for for user to enter data
    @IBAction func AddPhoto(sender: AnyObject) {
        currentPhoto =  Photo()
        photos.append(currentPhoto)
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    //If user selects delete action photo is removed from array, collectionview is updated and plist file is updated
    //This is called by viewDidAppear (condition is tested there)
    private func DeletePhoto(){
        //Removes the photo at the currentIndex (The photo the user selected)
        photos.removeAtIndex(currentIndex)
        collectionView?.reloadData()
        //Calls function to save photos to file
        SaveToFile()
        
    }
    
    //Saves photos to property lists and writes to file
    private func SaveToFile(){
        //convert array of photos to NSArray of NSDictionary of photos.
        let arrayPLIST: NSArray = photos.map { $0.propertyListRep()}
        //Get the file path and name
        let saveDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        let fileName = saveDir.stringByAppendingPathComponent("data.plist")
        //Write array to file
         arrayPLIST.writeToFile(fileName, atomically: true)
    }
    
    private func LoadFromFile() {
         //Get the file path and name
        let saveDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        let fileName = saveDir.stringByAppendingPathComponent("data.plist")
        //Get dictionary of photos and convert them back to an array of photos
        if let fileContent = NSArray(contentsOfFile: fileName) as? Array<NSDictionary> {
        let arrayReadPhotos = fileContent.map{ Photo(PropertyList: $0)}
        //Put newly converted array of photos in models photo array
        photos = arrayReadPhotos
        //Refresh the colletion data
        collectionView?.reloadData()
    }
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
        } else if let dvc = segue.destinationViewController as? PhotoViewController {
            dvc.photo = currentPhoto
            dvc.delegate = self
        }
    }
    
    func detailViewController(dvc: DetailViewController, photo: Photo){
        navigationController?.popToViewController(self, animated: true)
        collectionView?.reloadData()

   
   }
    func photoViewController(dvc: PhotoViewController,photo: Photo){
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

    //Set the image for the Cells of the Collection view
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
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
        //Save any changes back to file
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        //Set the current photo to what the user has selected and present the DetailView for said photo
        currentPhoto = photos[indexPath.row]
        //Set currentIndex in case user deletes photo
        self.performSegueWithIdentifier("ShowFull", sender: self)
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




