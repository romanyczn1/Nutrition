//
//  ShadowView.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import UIKit

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setUpView()
        }
    }
    
    public func changeView(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .white
            self.layer.borderWidth = 0
            setupShadow()
        } else {
            self.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
            self.layer.borderWidth = 0.15
            hideShadow()
        }
    }
    
    private func setUpView() {
        self.layer.borderWidth = 0.15
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 13
    }

    private func setupShadow() {
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 13, height: 13)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func hideShadow() {
        self.layer.shadowOpacity = 0
    }
}
