//
//  Intropage.swift
//  AIAR
//
//  Created by 陈若鑫 on 31/01/2024.
//
import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    
    //video from: https://www.youtube.com/watch?v=RhlQvbvMg-0
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let player = AVPlayer(url: Bundle.main.url(forResource: "backgroundVideo", withExtension: "mov")!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
        
        player.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class VideoPlayerViewController: UIViewController {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = AVPlayer(url: Bundle.main.url(forResource: "backgroundVideo", withExtension: "mov")!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            player?.play()
        }
        
        player.play()
        
        self.player = player
        self.playerLayer = playerLayer
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
        NotificationCenter.default.removeObserver(self)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            VideoPlayerView()
                .ignoresSafeArea()
            
            VStack {
                Text("Welcome to Galasa AR AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
    
                Text("Technical Document Enhancer")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                
                NavigationLink(destination: ARACTUAL()) {
                    Text("Go to the Majic World")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(8)
                }
                NavigationLink(destination: TeamRepresentable()) {
                    Text("Developer introduction")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(8)
                }
            }
        }
        .navigationBarTitle("Main Page") // Set the title in the navigation bar
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
