//
//  MenuViewController.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/23.
//

import AVKit
import MobileCoreServices
import UIKit

class MenuViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNameTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
    }
    
    private func configureNameTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Birthday boy/girl name",
            attributes: [.foregroundColor: UIColor.systemGray])
        nameTextField.delegate = self
    }

    @IBAction func selectVideoDidTapped(_ sender: UIButton) {
        VideoHelper.startMediaBrowser(
            delegate: self,
            sourceType: .savedPhotosAlbum)
    }
    
    @IBAction func recordVideoDidTapped(_ sender: UIButton) {
        VideoHelper.startMediaBrowser(
            delegate: self,
            sourceType: .camera)
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

extension MenuViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    
}
