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
        //SaveToFile()
    }
    
    
    @IBAction func SAvePRess(sender: AnyObject) {
        SaveToFile()
    }
    @IBAction func load(sender: AnyObject) {
        let saveDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = saveDir.stringByAppendingPathComponent("data.plist")
        
         if let loadedphoto = NSMutableDictionary(contentsOfFile: fileName) {
            if let Ltitle = loadedphoto.objectForKey("title") as? String {
                if let Ltags = loadedphoto.objectForKey("tags") as? [String] {
                    if let Lurl = loadedphoto.objectForKey("url") as? String {
                        photos.append(Photo(title: Ltitle, tags: Ltags, url: Lurl) )
                        collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        currentPhoto = Photo(title: "", tags: [], url: "")
        photos.append(currentPhoto)
        performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    private func DeletePhoto(){
        
            photos.removeAtIndex(currentIndex)
            collectionView?.reloadData()
            // Write changes to file??
        
    }
    
    private func SaveToFile(){
        
        for elements in photos {
            //Add photos to property list
        }
        
        
        
        let pho = Photo(title: "TEST", tags: ["1", "2"], url: "http://www.griffith.edu.au/__data/assets/image/0019/632332/gu-header-logo.png")
        let pl = pho.propertyList()
        let saveDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = saveDir.stringByAppendingPathComponent("data.plist")
        let test = pl.writeToFile(fileName, atomically: true)
        println("SAVE TO FILE \(test)")
        
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
