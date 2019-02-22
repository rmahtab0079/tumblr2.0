//
//  PhotoDetailsViewController.swift
//  tumblr2.0
//
//  Created by Rageeb Mahtab on 2/21/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    
    var post: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            if let photos = post["photos"] as? [[String: Any]]{
                let photo = photos[0]
                let originalSize = photo["original_size"] as! [String: Any]
                let urlString = originalSize["url"] as! String
                let url = URL(string: urlString)
                let placeholderImage = UIImage(named: "placeholder")
                myImage.af_setImage(withURL: url!,placeholderImage: placeholderImage,imageTransition: .crossDissolve(0.2))
                
            }
        }
       
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
