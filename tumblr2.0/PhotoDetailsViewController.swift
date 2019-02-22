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
        //user initiated the action
        myImage.isUserInteractionEnabled = true
        //display fullscreen image when user tap the photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        myImage.addGestureRecognizer(tapGesture)
        //scroll view to display the content of caption
        //scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: captionLabel.bottomAnchor).isActive = true
       
        
    }
    
    
    //code to display fullscreen image when tap and pinch to zoom
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        //zoom the photo using pinchGesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        newImageView.addGestureRecognizer(pinchGesture)
        //pan the photo while zooming
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan(sender:)))
        newImageView.addGestureRecognizer(pan)
        //dismiss the fullscreen when tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //code to zoom the image when pinch
    @objc func pinchGesture(sender:UIPinchGestureRecognizer){
        //sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        //sender.scale = 1.0func pinch(sender:UIPinchGestureRecognizer) {
        if sender.state == .began {
            let currentScale = self.myImage.frame.size.width / self.myImage.bounds.size.width
            let newScale = currentScale*sender.scale
            if newScale > 1 {
                self.isZooming = true
            }
        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            let currentScale = self.myImage.frame.size.width / self.myImage.bounds.size.width
            var newScale = currentScale*sender.scale
            
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.myImage.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            guard let center = self.originalImageCenter else {return}
            UIView.animate(withDuration: 0.3, animations: {
                self.myImage.transform = CGAffineTransform.identity
                self.myImage.center = center
            }, completion: { _ in
                self.isZooming = false
            })
        }
        
    }
    
    //code to pan while zooming
    @objc func pan(sender: UIPanGestureRecognizer) {
        if self.isZooming && sender.state == .began {
            self.originalImageCenter = sender.view?.center
        } else if self.isZooming && sender.state == .changed {
            let translation = sender.translation(in: myImage)
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.myImage.superview)
        }
    }
    
    //code to dismiss fullscreen image
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
