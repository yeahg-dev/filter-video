//
//  MenuViewController.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/23.
//

import AVKit
import MobileCoreServices
import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectVideoDidTapped(_ sender: UIButton) {
        VideoHelper.startMediaBrowser(
            delegate: self,
            sourceType: .savedPhotosAlbum)
    }
    
}

extension MenuViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        else { return }
        
        dismiss(animated: true) {
            let player = AVPlayer(url: url)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            self.present(playerVC, animated: true, completion: nil)
        }
    }
}

extension MenuViewController: UINavigationControllerDelegate {
    
}
