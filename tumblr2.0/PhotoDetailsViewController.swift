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
    

    @IBAction func onTapImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "zoomSegue", sender: UITapGestureRecognizer.self)
    }
    
    var post: [String: Any]?
    
    var isZooming = false
    
    var originalImageCenter:CGPoint?
    
    
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
        
        myImage.isUserInteractionEnabled = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var fullScreenVC = segue.destination as! FullScreenPhotoViewController
        fullScreenVC.image = myImage.image
        
    }
        //user initiated the action
        
        //display fullscreen image when user tap the photo
       
        //scroll view to display the content of caption
        //scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: captionLabel.bottomAnchor).isActive = true
       
        
    
    

    //code to zoom the image when pinch
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
