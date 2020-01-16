//
//  ToastWindow.swift
//  Toast
//
//  Created by Koji Murata on 2020/01/16.
//

import UIKit

final class ToastWindow: UIWindow {
    init() {
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                super.init(windowScene: scene)
            } else {
                super.init(frame: UIScreen.main.bounds)
            }
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        rootViewController = ToastViewController()
        windowLevel = .statusBar
    }
    
    func present(message: String, info: ToastInfoProvider) {
        makeKeyAndVisible()
        (rootViewController as! ToastViewController).present(message: message, info: info)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event) as? ToastView
    }
}
