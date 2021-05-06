//
//  Alert.swift
//  BrainStation-Test
//
//  Created by Sudipto Roy on 5/6/21.
//  Copyright © 2021 Code_X Systems. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    
    /// Show Alert
    /// - Parameters:
    ///   - inViewController: The viewController in which the alert will display
    ///   - title: Alert Title
    ///   - message: Alert Message
    static func showAlert(_ inViewController: UIViewController, title: String , message: String)
    {
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                             inViewController.present(alert, animated: true)
    }
}
