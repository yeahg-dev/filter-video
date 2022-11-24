//
//  PlayerViewController.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/24.
//

import AVKit
import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    var videoURL: URL?
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = videoURL else {
            print("video URL does not exist")
            return
        }
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      playerLayer.frame = videoView.bounds
    }
    
    @IBAction func saveDidTapped(_ sender: UIButton) {
        
    }

}
