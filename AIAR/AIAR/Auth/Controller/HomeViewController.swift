//
//  HomeViewController.swift
//  AIAR
//
//  Created by 陈若鑫 on 25/03/2024.
//

import UIKit
import SwiftUI
import AVKit

class HomeViewController : UIViewController {
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var mainPageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(mainPageButton)
    }
    
    func setUpVideo(){
        let bundlePath = Bundle.main.path(forResource: "backgroundVideo1", ofType: "mov")
        guard bundlePath != nil else{
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
  }
    
@objc func videoDidEnd(){
        videoPlayer?.seek(to: CMTime.zero)
        videoPlayer?.play()
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func mainPageTapped(_ sender: Any) {
        /*    // 将SwiftUI视图MainView封装到UIHostingController中
                let mainView = MainView()
                let hostingController = UIHostingController(rootView: mainView)
                
                // 通过navigationController推送视图
                navigationController?.pushViewController(hostingController, animated: true)*/
        
        let swiftUIView = MainView() // Create your SwiftUI view
              let hostingController = UIHostingController(rootView: swiftUIView) // Wrap it in a UIHostingController
        
        hostingController.modalPresentationStyle = .fullScreen
              
              // Present the hosting controller modally or push it if you are using a navigation controller
              self.present(hostingController, animated: true, completion: nil)
              
              // If using a navigation controller and want to push:
              // self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
}

