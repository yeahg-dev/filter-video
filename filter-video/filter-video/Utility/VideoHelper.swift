//
//  VideoHelper.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/23.
//

import UIKit
import MobileCoreServices

struct VideoHelper {
    
    static func startMediaBrowser(
      delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
      sourceType: UIImagePickerController.SourceType
    ) {
      guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
          print("return")
          return
      }

      let mediaUI = UIImagePickerController()
      mediaUI.sourceType = sourceType
      mediaUI.mediaTypes = [kUTTypeMovie as String]
      mediaUI.allowsEditing = true
      mediaUI.delegate = delegate
      delegate.present(mediaUI, animated: true, completion: nil)
    }
    
}
