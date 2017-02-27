//
//  TabBarController.swift
//  MemeMe
//
//  Created by CarlJohan on 21/02/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet var SentMemesTabBar: UINavigationItem!
    
    //override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
    //}
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func AddMemeBtn(_ sender: Any) {
    
        let addMemeVC = self.storyboard!.instantiateViewController(withIdentifier: "MakeAMemeViewController") as! MakeAMemeViewController
        
        self.present(addMemeVC, animated: true, completion: nil)
        
    }

    
}
