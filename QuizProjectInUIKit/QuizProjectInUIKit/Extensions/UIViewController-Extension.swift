//
//  UIViewController-Extension.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

extension UIViewController {
    
    func showSingleBtnAlert(title: String, message: String, actionTitle: String = "OK", handler:(() -> Void)? = nil) {
        
        let alert = UIAlertController.singleBtnAllert(title: title, message: message, actionTitle: actionTitle, handler: handler)
        self.present(alert, animated: true)
    }
    
    func showCommonLabelAlert(title: String = "", message: String = "", okActionTitle: String = "OK", okHandler: (() -> Void)? = nil, cancelActionTitle: String = "Cancel", cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController.commonLabelAlert(title: title, message: message, okActionTitle: okActionTitle, okHandler: okHandler, cancelActionTitle: cancelActionTitle, cancelHandler: cancelHandler)

        self.present(alert, animated: true)
        
    }
    
}
