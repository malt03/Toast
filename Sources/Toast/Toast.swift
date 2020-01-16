//
//  Toast.swift
//  Toast
//
//  Created by Koji Murata on 2020/01/16.
//

import UIKit

public final class Toast {
    public static let shared = Toast()
    
    public func present(message: String, info: ToastInfoProvider) {
        DispatchQueue.main.async {
            self.window.present(message: message, info: info)
        }
    }

    private let window = ToastWindow()
    
    private init() {
        window.makeKeyAndVisible()
    }
}

public protocol ToastInfoProvider {
    var backgroundColor: UIColor { get }
    var messageColor: UIColor { get }
    var duration: TimeInterval { get }
}
