//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Matthew Lee on 19/04/2015.
//  Copyright (c) 2015 Matthew Lee. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView
    
   override init(frame: CGRect) {
   
        imageView = UIImageView(frame: frame)
        imageView.contentMode = .ScaleAspectFit
        super.init(frame: frame)
        let bounds = self.bounds
        imageView.frame = bounds
        addSubview(imageView)
    }

   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
}
