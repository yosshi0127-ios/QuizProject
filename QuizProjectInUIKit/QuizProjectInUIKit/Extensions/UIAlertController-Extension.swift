//
//  UIAlertController-Extension.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
//

import UIKit

extension UIAlertController {
    
    class func singleBtnAllert(title: String, message: String, actionTitle: String = "OK", handler:(() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action) in
            handler?()
        }))
        
        return alert
    }
    
    class func commonLabelAlert(title: String,
                                message: String,
                                okActionTitle: String = "OK",
                                okHandler: (() -> Void)? = nil,
                                cancelActionTitle: String = "Cancel",
                                cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okActionTitle, style: .default, handler: { action in
            okHandler?()
        }))
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel, handler: { action in
            cancelHandler?()
        }))
        
        return alert
    }
}
