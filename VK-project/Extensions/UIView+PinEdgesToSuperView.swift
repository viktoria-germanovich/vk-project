//
//  UIView+PinEdgesToSuperView.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import UIKit

extension UIView {
    func pinEdgesToSuperview(_ distance:CGFloat = 0 ){
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 0),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 0),
        ])
    }
}
