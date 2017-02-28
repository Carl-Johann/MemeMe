//
//  SentMemesDetatilVC.swift
//  MemeMe
//
//  Created by CarlJohan on 23/02/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class SentMemesDetailViewController: UIViewController {
    
    @IBOutlet var SentMemesDetailViewControllerImage: UIImageView!
    
    var meme: Meme!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        self.SentMemesDetailViewControllerImage.image = self.meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
