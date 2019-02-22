//
//  FullScreenPhotoViewController.swift
//  tumblr2.0
//
//  Created by Rageeb Mahtab on 2/22/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    

    
    var image : UIImage!
    
//    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        imageView.image = self.image
        scrollView.contentSize = imageView.image!.size
        
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: false)
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
