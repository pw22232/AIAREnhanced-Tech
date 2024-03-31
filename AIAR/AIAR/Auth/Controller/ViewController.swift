//
//  ViewController.swift
//  AIAR
//
//  Created by 陈若鑫 on 25/03/2024.
//

import UIKit
import AVKit


class ViewController : UIViewController {
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
  }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
       // Utilities.styleHollowButton(loginButton)
        
    }
    
   func setUpVideo(){
        //get the path to the resource in the bundle
        
     let bundlePath =  Bundle.main.path(forResource: "backgroundVideo1", ofType: "mov")
        guard bundlePath != nil else{
            return
        }
        
        //create a url
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create video player item
        let item = AVPlayerItem(url: url)
        
        //create player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust size,frame
       videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
      
        view.layer.insertSublayer(videoPlayerLayer!, at:0)
        
         //add to view and play
        videoPlayer?.playImmediately(atRate: 1)
       
       NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    @objc func videoDidEnd() {
        // video end, back to beginning
        videoPlayer?.seek(to: CMTime.zero)
        videoPlayer?.play()
    }
    deinit {
         // remove observer
         NotificationCenter.default.removeObserver(self)
     }
    
}
