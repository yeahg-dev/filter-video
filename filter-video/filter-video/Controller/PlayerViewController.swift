//
//  PlayerViewController.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/24.
//

import AVKit
import UIKit
import Photos

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
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.videoURL!)
        }) { [weak self] (isSaved, error) in
            if isSaved {
                print("Video saved.")
            } else {
                print("Cannot save video.")
                print(error ?? "unknown error")
            }
            DispatchQueue.main.async {
                self?.presentSaveSucessAlert(handler: { _ in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    private func presentSaveSucessAlert(
        handler: @escaping (UIAlertAction) -> Void)
    {
        let alert = UIAlertController(
            title: "저장 완료!",
            message: nil,
            preferredStyle: .alert)
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default,
            handler: handler)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
}
