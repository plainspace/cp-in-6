//
//  ViewController.swift
//  Instagram
//
//  Created by Jared on 3/9/16.
//  Copyright © 2016 plainspace. All rights reserved.
//

import UIKit

import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos: [NSDictionary]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 320;
        
        photos = []

        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=ce441d8f955848beb6dc54fd9f0ecd6c")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            // print("responseDictionary: \(responseDictionary)")
                            // Store the returned array of media in your photos property
                            self.photos = responseDictionary["data"] as! [NSDictionary]
                            // print("meow",self.photos)
                            self.tableView.reloadData()

                    }
                }
        });
        task.resume()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if let photos = photos {
//            return photos.count
//        }
//        return 0
        
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell

//        if let photos = photos {
//            let photo = photos[indexPath.row]
//            let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
//            cell.photoImageView.setImageWithURL(NSURL(string: urlString)!)
//        }
        
        let photo = photos[indexPath.row]
        let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
        cell.photoImageView.setImageWithURL(NSURL(string: urlString)!)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

