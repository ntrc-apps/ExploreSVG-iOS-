//
//  HomeViewCollectionCell.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/18/22.
//

import UIKit

class HomeViewCollectionCell: UICollectionViewCell
{
    @IBOutlet weak var BGCView: UIView!
    @IBOutlet weak var ImageHolderView: UIView!
    @IBOutlet weak var FeaturedTitle: UILabel!
    

override func awakeFromNib() {
        super.awakeFromNib()
    
    ImageHolderView.layer.cornerRadius = 20.0
    ImageHolderView.layer.masksToBounds = true
    BGCView.layer.cornerRadius = 20.0
    BGCView.layer.masksToBounds = true
}

}
