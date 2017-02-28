//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by CarlJohan on 21/02/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var SentMemesCollectionView: UICollectionView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func didRotate(from: UIInterfaceOrientation) {
        let xAxsis = view.frame.size.width
        
        if from.isPortrait {
            setCellStats(xAxsis, 5.0)
        } else {
            setCellStats(xAxsis, 3.0)
        }
    }
    
    
    
    func setCellStats(_ xAxsis: CGFloat, _ numberOfElements: CGFloat) {
        
        let space:CGFloat = 3.0
        let cellSideHeight = (xAxsis - (numberOfElements * space)) / numberOfElements

        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: cellSideHeight, height: cellSideHeight)

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xAxsis = view.frame.size.width
        setCellStats(xAxsis, 3.0)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.SentMemesCollectionView.reloadData()
    }
    
    
 
    @IBAction func AddMemeButton(_ sender: Any) {
        let addMemeVC = self.storyboard!.instantiateViewController(withIdentifier: "MakeAMemeViewController") as! MakeAMemeViewController
        
        self.present(addMemeVC, animated: true, completion: nil)

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
