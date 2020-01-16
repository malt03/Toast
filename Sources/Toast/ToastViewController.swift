//
//  ToastViewController.swift
//  Toast
//
//  Created by Koji Murata on 2020/01/16.
//  Copyright © 2020 Koji Murata. All rights reserved.
//

import UIKit

final class ToastViewController: UIViewController {
    private var presentingToasts = [ToastView]()
    private var dismissInfos = [ToastView: DismissInfo]()
    private let lock = NSLock()
    
    private struct DismissInfo {
      let mainConstraints: [NSLayoutConstraint]
      let animateConstraints: [NSLayoutConstraint]
    }
    
    func present(message: String, infoProvider: ToastInfoProvider) {
        lock.lock()

        let toastView = ToastView(message: message, infoProvider: infoProvider)
        defer {
            presentingToasts.append(toastView)
            lock.unlock()
        }

        toastView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(_:))))
        toastView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 50)
        if let lastToastView = presentingToasts.last {
            view.insertSubview(toastView, belowSubview: lastToastView)
        } else {
            view.addSubview(toastView)
        }
        
        var mainConstraints = [
            view.leadingAnchor.constraint(equalTo: toastView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: toastView.trailingAnchor),
        ]
        let bottomConstraint = toastView.topAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.priority = .init(999)
        mainConstraints.append(bottomConstraint)
        
        var animateConstraints = [NSLayoutConstraint]()
        let animateConstraint = toastView.mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        animateConstraints.append(animateConstraint)
        
        for existToastView in presentingToasts {
            let existToastViewBottomConstraint = toastView.topAnchor.constraint(lessThanOrEqualTo: existToastView.topAnchor)
            mainConstraints.append(existToastViewBottomConstraint)
            let highestToastViewAnimateConstraint = toastView.mainView.bottomAnchor.constraint(lessThanOrEqualTo: existToastView.topAnchor)
            animateConstraints.append(highestToastViewAnimateConstraint)
        }
        
        view.addConstraints(mainConstraints)
        view.layoutIfNeeded()
        
        view.addConstraints(animateConstraints)
        UIView.animate(withDuration: 0.24) { self.view.layoutIfNeeded() }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + infoProvider.duration) {
            self.dismiss(toastView: toastView)
        }
        
        dismissInfos[toastView] = DismissInfo(mainConstraints: mainConstraints, animateConstraints: animateConstraints)
    }
    
    @objc private func dismiss(_ sender: UITapGestureRecognizer) {
        guard let toastView = sender.view as? ToastView else { return }
        dismiss(toastView: toastView)
    }
    
    func dismiss(toastView: ToastView) {
        lock.lock()
        defer { lock.unlock() }
        
        guard let dismissInfo = dismissInfos[toastView] else { return }
        if let index = presentingToasts.firstIndex(of: toastView) { presentingToasts.remove(at: index) }
        dismissInfos.removeValue(forKey: toastView)

        NSLayoutConstraint.deactivate(dismissInfo.animateConstraints)
        UIView.animate(withDuration: 0.24, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            NSLayoutConstraint.deactivate(dismissInfo.mainConstraints)
            toastView.removeFromSuperview()
        })
    }
}
