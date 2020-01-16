//
//  ToastView.swift
//  Toast
//
//  Created by Koji Murata on 2020/01/16.
//

import UIKit

final class ToastView: UIView {
    let mainView = UIView()
    private let messageLabel = UILabel()
    
    init(message: String, info: ToastInfoProvider) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350))
        
        mainView.isUserInteractionEnabled = false
        messageLabel.isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        messageLabel.font = .systemFont(ofSize: 15)
        addSubview(mainView)
        mainView.addSubview(messageLabel)
        
        addConstraints([
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300),
            messageLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
        ])
        
        backgroundColor = info.backgroundColor
        messageLabel.text = message
        messageLabel.textColor = info.messageColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
