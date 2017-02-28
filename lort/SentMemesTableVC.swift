//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by CarlJohan on 21/02/17.
//  Copyright © 2017 Carl-Johan. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var TableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewWillAppear(_ animated: Bool) {
        print("Table View Did Appear")
        self.TableView.reloadData()
    }
    
    @IBAction func AddMemeButton(_ sender: Any) {
        let addMemeVC = self.storyboard!.instantiateViewController(withIdentifier: "MakeAMemeViewController") as! MakeAMemeViewController
            
        self.present(addMemeVC, animated: true, completion: nil)
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return appDelegate.memes.count
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let memeAtRow = appDelegate.memes[indexPath[1]]
        
        cell.textLabel?.text = (memeAtRow.topText + " " + memeAtRow.bottomText)
        cell.imageView?.image = memeAtRow.originalImage
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemesDetailViewController") as! SentMemesDetailViewController
        
        detailViewController.meme = appDelegate.memes[indexPath[1]]
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
        print("Presented DetailView")
        
    }
    
    
    
}
