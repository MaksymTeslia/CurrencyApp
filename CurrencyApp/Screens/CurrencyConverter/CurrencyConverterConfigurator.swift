//
//  SettingUpUIElements.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 24.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let backToCurrencyInfoScreenButtonTitle = "Exchange rates"
}

fileprivate struct UIElementsScaleSizes {
    static let baseViewsCornerRadius:CGFloat = 20
    static let baseViewsBorderWidth:CGFloat = 0.2
    static let baseViewsSideConstraint:CGFloat = 10
    static let baseViewsScaleHeight:CGFloat = 0.3
    static let baseViewNameLabelFontSize:CGFloat = 24
    static let baseViewNameLabelTopConstraint:CGFloat = 10
    static let baseViewNameLabelScaleHeight:CGFloat = 0.2
    static let pickerViewsAndTextViewsSideSpace:CGFloat = 25
    static let firstPickerTopConstraint:CGFloat = 20
    static let pickerViewsScaleWidthAndHeight:CGFloat = 0.3
    static let textViewsFontSize:CGFloat = 18
    static let textViewsCornerRadius:CGFloat = 5
    static let textViewsBorderSize:CGFloat = 0.2
    static let textViewsScaleWidth:CGFloat = 0.5
    static let textViewsScaleHeight:CGFloat = 0.15
    static let backToCurrencyTableButtonCornerRadius:CGFloat = 5
    static let backToCurrencyTableButtonBorderWidth:CGFloat = 0.2
    static let backToCurrencyTableButtonSideSpace:CGFloat = 50
    static let backToCurrencyTableButtonScaleHeight:CGFloat = 0.075
}

class CurrencyConverterConfigurator {
    func setUpBaseViews(currencyBaseView currencyView: UIView,
                        preciousMetalsBaseView metalsView: UIView,
                        withViewController viewController: UIViewController) {
        
        viewController.view.addSubviews(currencyView, metalsView)
        
        currencyView.frame = CGRect(x: 0, y: 0,
                                    width: viewController.view.frame.width * 0.8,
                                    height: currencyView.frame.width)
        
        currencyView.backgroundColor = .systemGroupedBackground
        currencyView.layer.borderColor = UIColor.darkGray.cgColor
        currencyView.layer.borderWidth = UIElementsScaleSizes.baseViewsBorderWidth
        currencyView.layer.cornerRadius = UIElementsScaleSizes.baseViewsCornerRadius
        
        let oneTenthOfTheScreen = viewController.view.frame.height * 0.1
        let fivePeercentOfTheScreen = viewController.view.frame.height * 0.05
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: oneTenthOfTheScreen).isActive = true
        currencyView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: UIElementsScaleSizes.baseViewsSideConstraint).isActive = true
        currencyView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -UIElementsScaleSizes.baseViewsSideConstraint).isActive = true
        currencyView.heightAnchor.constraint(equalTo: viewController.view.heightAnchor, multiplier: UIElementsScaleSizes.baseViewsScaleHeight).isActive = true
        
        metalsView.frame = CGRect(x: 0, y: 0,
                                  width: viewController.view.frame.width * 0.8,
                                  height: currencyView.frame.width)
        
        metalsView.backgroundColor = .systemGroupedBackground
        metalsView.layer.borderColor = UIColor.darkGray.cgColor
        metalsView.layer.borderWidth = UIElementsScaleSizes.baseViewsBorderWidth
        metalsView.layer.cornerRadius = UIElementsScaleSizes.baseViewsCornerRadius
        
        metalsView.translatesAutoresizingMaskIntoConstraints = false
        metalsView.topAnchor.constraint(equalTo: currencyView.bottomAnchor, constant: fivePeercentOfTheScreen).isActive = true
        metalsView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: UIElementsScaleSizes.baseViewsSideConstraint).isActive = true
        metalsView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -UIElementsScaleSizes.baseViewsSideConstraint).isActive = true
        metalsView.heightAnchor.constraint(equalTo: viewController.view.heightAnchor, multiplier: UIElementsScaleSizes.baseViewsScaleHeight).isActive = true
    }
    
    // MARK: - Setting up inner elements (name label, pickers and textViews) for currency and precious metals base views. This function is going to be used for both currency and precious metals base view elements
    
        func setUpBaseView(withFirstPicker firstPicker: UIPickerView,
                               andSecondPicker secondPicker: UIPickerView,
                               addingTextViewForFirstPicker firstTextView: UITextView,
                               andAnotherTextViewForSecondPicker secondTextView: UITextView,
                               havingNameLabelAboveThem nameLabel: UILabel,
                               addingNameToTheLabel labelName: String,
                               pinningThemAllToBaseView baseView: UIView,
                               withViewController viewController: UIViewController) {
        
        viewController.view.addSubviews(firstPicker, secondPicker, firstTextView, secondTextView, nameLabel)
        
        nameLabel.frame = CGRect(x: 0, y: 0,
                                 width: baseView.frame.width,
                                 height: baseView.frame.height * 0.2)
        
        nameLabel.text = labelName
        nameLabel.font = .boldSystemFont(ofSize: UIElementsScaleSizes.baseViewNameLabelFontSize)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: UIElementsScaleSizes.baseViewNameLabelTopConstraint).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: UIElementsScaleSizes.baseViewNameLabelScaleHeight).isActive = true
        
        //MARK: - First Picker View Setup
        setUpPickerView(firstPicker, viewController: viewController, baseView: baseView)
        
        firstPicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                         constant: UIElementsScaleSizes.firstPickerTopConstraint).isActive = true
        firstPicker.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: UIElementsScaleSizes.pickerViewsAndTextViewsSideSpace).isActive = true
        firstPicker.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: UIElementsScaleSizes.pickerViewsScaleWidthAndHeight).isActive = true
        firstPicker.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: UIElementsScaleSizes.pickerViewsScaleWidthAndHeight).isActive = true
        
        //MARK: - Second Picker View Setup
        setUpPickerView(secondPicker, viewController: viewController, baseView: baseView)
        
        secondPicker.topAnchor.constraint(equalTo: firstPicker.bottomAnchor).isActive = true
        secondPicker.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: UIElementsScaleSizes.pickerViewsAndTextViewsSideSpace).isActive = true
        secondPicker.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: UIElementsScaleSizes.pickerViewsScaleWidthAndHeight).isActive = true
        secondPicker.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: UIElementsScaleSizes.pickerViewsScaleWidthAndHeight).isActive = true
        
        //MARK: - First Text View Setup
        setupTextView(firstTextView, viewController: viewController, baseView: baseView)
        
        firstTextView.centerYAnchor.constraint(equalTo: firstPicker.centerYAnchor).isActive = true
        firstTextView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -UIElementsScaleSizes.pickerViewsAndTextViewsSideSpace).isActive = true
        firstTextView.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: UIElementsScaleSizes.textViewsScaleHeight).isActive = true
        firstTextView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: UIElementsScaleSizes.textViewsScaleWidth).isActive = true
        
        //MARK: - Second Text View Setup
        setupTextView(secondTextView, viewController: viewController, baseView: baseView)
        
        secondTextView.centerYAnchor.constraint(equalTo: secondPicker.centerYAnchor).isActive = true
        secondTextView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -UIElementsScaleSizes.pickerViewsAndTextViewsSideSpace).isActive = true
        secondTextView.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: UIElementsScaleSizes.textViewsScaleHeight).isActive = true
        secondTextView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: UIElementsScaleSizes.textViewsScaleWidth).isActive = true
    }
    
    // MARK: - Setting up a button which is going go back to currency exchange rates table screen
        func setUpBackButton(_ button: UIButton,
                                 withViewController viewController: UIViewController) {
        
        viewController.view.addSubview(button)
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = UIElementsScaleSizes.backToCurrencyTableButtonCornerRadius
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = UIElementsScaleSizes.backToCurrencyTableButtonBorderWidth
        
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: viewController.view.frame.width * 0.5,
                              height: viewController.view.frame.height * 0.1)
        
        let oneTenthOfTheView = viewController.view.frame.size.height * 0.1
        button.setTitle(Constants.backToCurrencyInfoScreenButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: button.frame.height * 0.25)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: UIElementsScaleSizes.backToCurrencyTableButtonSideSpace).isActive = true
        button.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -UIElementsScaleSizes.backToCurrencyTableButtonSideSpace).isActive = true
        button.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -oneTenthOfTheView).isActive = true
        button.heightAnchor.constraint(equalTo: viewController.view.heightAnchor, multiplier: UIElementsScaleSizes.backToCurrencyTableButtonScaleHeight).isActive = true
    }
    
    //MARK: - Functions for setup of similar values of picker and text views
    private func setupTextView(_ textView: UITextView, viewController: UIViewController, baseView: UIView) {
        textView.frame = CGRect(x: 0, y: 0,
                                width: baseView.frame.width * 0.4,
                                height: baseView.frame.height * 0.2)
        textView.delegate = viewController as? UITextViewDelegate
        textView.keyboardType = .numberPad
        textView.textContainer.maximumNumberOfLines = 1
        textView.font = .systemFont(ofSize: UIElementsScaleSizes.textViewsFontSize)
        textView.layer.cornerRadius = UIElementsScaleSizes.textViewsCornerRadius
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = UIElementsScaleSizes.textViewsBorderSize
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpPickerView(_ pickerView: UIPickerView, viewController: UIViewController, baseView: UIView) {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.frame = CGRect(x: 0, y: 0,
                                  width: baseView.frame.width * 0.4,
                                  height: baseView.frame.height * 0.2)
        pickerView.delegate = viewController as? UIPickerViewDelegate
        pickerView.dataSource = viewController as? UIPickerViewDataSource
    }
}
