//
//  ViewController.swift
//  Example
//
//  Created by Koji Murata on 2020/01/16.
//  Copyright © 2020 Koji Murata. All rights reserved.
//

import UIKit
import Toast

class ViewController: UIViewController {
    @IBOutlet weak var infoField: UITextField!
    @IBOutlet weak var errorField: UITextField!
    
    @IBAction func info() {
        Toast.shared.present(message: infoField.text ?? "", info: .info)
    }

    @IBAction func error() {
        Toast.shared.present(message: errorField.text ?? "", info: .error)
    }
}

extension Toast {
    func present(message: String, info: ToastInfo) {
        present(message: message, infoProvider: info)
    }
}

enum ToastInfo: ToastInfoProvider {
    case info
    case error

    var backgroundColor: UIColor {
        switch self {
        case .info:  return .systemGreen
        case .error: return .systemRed
        }
    }
    var messageColor: UIColor { .white }
    var duration: TimeInterval { 1 }
}
