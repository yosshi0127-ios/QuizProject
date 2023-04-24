//
//  VerticallyScreenViewController.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/24.
//

import UIKit

class VerticallyScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
