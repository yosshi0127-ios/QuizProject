//
//  AnimateImageModel.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

class AnimateImageModel {
    
    private var images: [UIImage] = []
    
    private var index = 0
    private let animationDuration: TimeInterval
    private let switchingInterval: TimeInterval

    init(images: [UIImage], animationDuration: TimeInterval = 1, switchingInterval: TimeInterval = 3) {
        self.images = images
        self.animationDuration = animationDuration
        self.switchingInterval = switchingInterval
    }
    
    func animateImageView(imageView: UIImageView) {
        // 画像をフェードで切り替えるアニメーション
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.switchingInterval) {
                self.animateImageView(imageView: imageView)
            }
        }
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        
        imageView.layer.add(transition, forKey: kCATransition)
        imageView.image = images[index]
        
        CATransaction.commit()
        
        index = index < images.count - 1 ? index + 1 : 0
    }
}
