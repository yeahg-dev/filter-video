//
//  CardLayoutDesign.swift
//  filter-video
//
//  Created by Moon Yeji on 2022/11/25.
//

import Foundation

enum CardLayoutDesign {
    
    case landscape
    case portrait
    
    var textFontSize: CGFloat {
        switch self {
        case .landscape:
            return 80
        case .portrait:
            return 60
        }
    }
    
    func imageLayerFrame(
        videoWidth: CGFloat,
        videoHeight: CGFloat,
        imageAspect: CGFloat)
    -> CGRect
    {
        switch self {
        case .landscape:
            let imageHeight = videoHeight * 0.45
            let imageWidth = imageHeight * imageAspect
            let positionX = (videoWidth - imageWidth)/2
            let positionY = videoHeight - imageHeight
            return CGRect(
                x: positionX,
                y: -imageHeight * 0.15,
                width: imageWidth,
                height: imageHeight)
        case .portrait:
            let imageHeight = videoWidth/imageAspect
            return CGRect(
                x: 0,
                y: -imageHeight * 0.15,
                width: videoWidth,
                height: imageHeight)
        }
    }
}
