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
    
    private let editor = VideoEditor()
    private var pickedURL: URL?
    
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
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard
            let url = info[.mediaURL] as? URL,
            let name = nameTextField.text
        else {
            print("Cannot get video URL")
            return
        }
        
        //        showInProgress()
        dismiss(animated: true) {
            self.editor.makeBirthdayCard(fromVideoAt: url, forName: name) { exportedURL in
                //            self.showCompleted()
                guard let exportedURL = exportedURL else {
                    return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let playerVC = storyboard.instantiateViewController(
                    withIdentifier: "PlayerViewController") as? PlayerViewController else {
                    print("Fail to Initialize PlayerViewController")
                    return
                }
                playerVC.videoURL = exportedURL
                self.navigationController?.pushViewController(
                    playerVC,
                    animated: true)
            }
        }
    }
}

extension MenuViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
