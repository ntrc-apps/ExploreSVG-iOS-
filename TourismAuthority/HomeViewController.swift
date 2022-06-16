//
//  HomeViewController.swift
//  TourismAuthority
//
//  Created by Chavez Bobb on 5/10/22.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var cell: UICollectionViewCell!
    
    
    
    
    
    override func viewDidLoad() {
        
        
        
    super.viewDidLoad()
        
        collectionview.dataSource = self
        
        
        
    }
}

extension HomeViewController :

UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "HomeViewCollectionCell", for: indexPath)
        
        return cell
    }
}


