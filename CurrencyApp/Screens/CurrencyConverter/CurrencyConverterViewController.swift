//
//  CurrencyConverterViewConrollerViewController.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let topBaseViewName = "Currency exchange"
    static let bottomBaseViewName = "Precious metals exchange"
}

class CurrencyConverterViewController: UIViewController, CurrencyConverterViewDataDelegate {
    let baseViewForCurrencyOperations = UIView()
    let baseViewForPreciousMetalsOperations = UIView()
    let firstPickerViewForCurrencyOperations = UIPickerView()
    let secondPickerViewForCurrencyOperations = UIPickerView()
    let firstTextViewForCurrencyOperations = UITextView()
    let secondTextViewForCurrencyOperations = UITextView()
    let nameLabelForCurrencyOperations = UILabel()
    let firstPickerViewForPreciousMetalsOperations = UIPickerView()
    let secondPickerViewForPreciousMetalsOperations = UIPickerView()
    let firstTextViewForPreciousMetalsOperations = UITextView()
    let secondTextViewForPreciousMetalsOperations = UITextView()
    let nameLabelForPreciousMetalsOperations = UILabel()
    let backToExchangeScreenButton = UIButton()
    let configurator = CurrencyConverterConfigurator()
    var viewData: CurrencyConverterInfoViewData!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configurator.setUpBaseViews(currencyBaseView: baseViewForCurrencyOperations,
                                    preciousMetalsBaseView: baseViewForPreciousMetalsOperations,
                                    withViewController: self)
        
        configurator.setUpBackButton( backToExchangeScreenButton,
                                      withViewController: self)
        
        backToExchangeScreenButton.addTarget(self,
                                             action: #selector(backToExchangeScreenButtonHasBeenPushed(_:)),
                                             for: .touchUpInside)
        setupUIOnBaseViews()
    }
    
    @objc func backToExchangeScreenButtonHasBeenPushed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func setupUIOnBaseViews() {
           configurator.setUpBaseView(withFirstPicker: firstPickerViewForCurrencyOperations,
                                      andSecondPicker: secondPickerViewForCurrencyOperations,
                                      addingTextViewForFirstPicker: firstTextViewForCurrencyOperations,
                                      andAnotherTextViewForSecondPicker: secondTextViewForCurrencyOperations,
                                      havingNameLabelAboveThem: nameLabelForCurrencyOperations,
                                      addingNameToTheLabel: Constants.topBaseViewName,
                                      pinningThemAllToBaseView: baseViewForCurrencyOperations,
                                      withViewController: self)
           
           configurator.setUpBaseView(withFirstPicker: firstPickerViewForPreciousMetalsOperations,
                                      andSecondPicker: secondPickerViewForPreciousMetalsOperations,
                                      addingTextViewForFirstPicker: firstTextViewForPreciousMetalsOperations,
                                      andAnotherTextViewForSecondPicker: secondTextViewForPreciousMetalsOperations,
                                      havingNameLabelAboveThem: nameLabelForPreciousMetalsOperations,
                                      addingNameToTheLabel: Constants.bottomBaseViewName,
                                      pinningThemAllToBaseView: baseViewForPreciousMetalsOperations,
                                      withViewController: self)
       }
}
//MARK: - UIPickerViewDelegate and UIPickerViewDataSource extensions

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case firstPickerViewForCurrencyOperations:
            return viewData.allMoneyCurrencies.count
        case secondPickerViewForCurrencyOperations:
            return viewData.allMoneyCurrencies.count
        case firstPickerViewForPreciousMetalsOperations:
            return viewData.allMoneyCurrencies.count
        case secondPickerViewForPreciousMetalsOperations:
            return viewData.allPreciousMetalsCurrencies.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case firstPickerViewForCurrencyOperations:
            return viewData.allMoneyCurrencies[row].currencyCode
        case secondPickerViewForCurrencyOperations:
            return viewData.allMoneyCurrencies[row].currencyCode
        case firstPickerViewForPreciousMetalsOperations:
            return viewData.allMoneyCurrencies[row].currencyCode
        case secondPickerViewForPreciousMetalsOperations:
            return viewData.allPreciousMetalsCurrencies[row].currencyCode
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case firstPickerViewForCurrencyOperations:
            
            viewData.firstCurrencyPickerChosenValue = viewData.allMoneyCurrencies[row].rate
            
            guard let valueGivenByTheFirstPicker = viewData.firstCurrencyPickerChosenValue,
                let valueGivenByTheSecondPicker = viewData.secondCurrencyPickerChosenValue,
                let valueGivenByTheSecondTextView = Double(secondTextViewForCurrencyOperations.text) else {return}
            
            let answerForTheFirstTextView = valueGivenByTheSecondPicker / valueGivenByTheFirstPicker * valueGivenByTheSecondTextView
            
            firstTextViewForCurrencyOperations.text = NSString(format: "%.2f", answerForTheFirstTextView) as String
            
        case secondPickerViewForCurrencyOperations:
            
            viewData.secondCurrencyPickerChosenValue = viewData.allMoneyCurrencies[row].rate
            
            guard let valueGivenByTheFirstPicker = viewData.firstCurrencyPickerChosenValue,
                let valueGivenByTheSecondPicker = viewData.secondCurrencyPickerChosenValue,
                let valueGivenByTheFirstTextView = Double(firstTextViewForCurrencyOperations.text) else { return }

            let answerForTheSecondTextView = valueGivenByTheFirstPicker / valueGivenByTheSecondPicker * valueGivenByTheFirstTextView
            
            secondTextViewForCurrencyOperations.text = NSString(format: "%.2f", answerForTheSecondTextView) as String
  
        case firstPickerViewForPreciousMetalsOperations:
            
            viewData.firstPreciousMetalsPickerChosenValue = viewData.allMoneyCurrencies[row].rate
            
            guard let valueGivenByTheFirstPicker = viewData.firstPreciousMetalsPickerChosenValue,
                let valueGivenByTheSecondPicker = viewData.secondPreciousMetalsPickerChosenValue,
                let valueGivenByTheSecondTextView = Double(secondTextViewForPreciousMetalsOperations.text) else { return }
            
            let answerForTheFirstTextView = valueGivenByTheSecondPicker / valueGivenByTheFirstPicker * valueGivenByTheSecondTextView
            
            firstTextViewForPreciousMetalsOperations.text = NSString(format: "%.2f", answerForTheFirstTextView) as String
            
        case secondPickerViewForPreciousMetalsOperations:
            
            viewData.secondPreciousMetalsPickerChosenValue = viewData.allPreciousMetalsCurrencies[row].rate
            
            guard let valueGivenByTheFirstPicker = viewData.firstPreciousMetalsPickerChosenValue,
                let valueGivenByTheSecondPicker = viewData.secondPreciousMetalsPickerChosenValue,
                let valueGivenByTheFirstTextView = Double(firstTextViewForPreciousMetalsOperations.text) else { return }
            
            let answerForTheSecondTextView = valueGivenByTheFirstPicker / valueGivenByTheSecondPicker * valueGivenByTheFirstTextView
            
            secondTextViewForPreciousMetalsOperations.text = NSString(format: "%.2f", answerForTheSecondTextView) as String
            
        default: break
        }
    }
}

//MARK: - UITextViewDelegate extension

extension CurrencyConverterViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case firstTextViewForCurrencyOperations:
            secondTextViewForCurrencyOperations.text = viewData.getOutputValueFor(
                userInputFromTextView: textView.text, isFirst: true, isMetal: false)
            
        case secondTextViewForCurrencyOperations:
            firstTextViewForCurrencyOperations.text = viewData.getOutputValueFor(
                userInputFromTextView: textView.text, isFirst: false, isMetal: false)
            
        case firstTextViewForPreciousMetalsOperations:
            secondTextViewForPreciousMetalsOperations.text = viewData.getOutputValueFor(
                userInputFromTextView: textView.text, isFirst: true, isMetal: true)
            
        case secondTextViewForPreciousMetalsOperations:
            firstTextViewForPreciousMetalsOperations.text = viewData.getOutputValueFor(
                userInputFromTextView: textView.text, isFirst: false, isMetal: true)
            
        default:
            break
        }
    }
}
