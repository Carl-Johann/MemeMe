//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by CarlJohan on 21/02/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet var SentMemesCollectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        self.SentMemesCollectionView.reloadData()
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCell", for: indexPath) as! SentMemesCollectionViewCell
        let memeAtRow = appDelegate.memes[indexPath[1]]
        
        
        cell.SentMemeTopText.text = memeAtRow.topText
        cell.SentMemeImage.image = memeAtRow.originalImage
        cell.SentMemeBottomText.text = memeAtRow.bottomText
        
        
        return cell
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemesDetailViewController") as! SentMemesDetailViewController
        
        detailViewController.meme = appDelegate.memes[indexPath[1]]
        self.navigationController!.pushViewController(detailViewController, animated: true)
        
    }

}
