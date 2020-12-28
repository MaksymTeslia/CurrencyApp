//
//  UIView.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 26.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ funcSubviews:UIView...) {
        for loopSubview in funcSubviews {
            addSubview(loopSubview)
        }
    }
    
    func setTranslatingOfAutoresizingMaskIntoConstraintsToFalseForViews(_ funcViews: UIView...) {
        for loopView in funcViews {
            loopView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func pinToBoundsOf(_ funcView:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: funcView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: funcView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: funcView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: funcView.trailingAnchor).isActive = true
    }
}
