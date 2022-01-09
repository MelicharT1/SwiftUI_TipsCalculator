//
//  OnboardingViewModel.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    private let tipsNamed: [String]           // = strings_tipsShortName
    private let symbols: [String]             // = strings_currencySymbols
    @Published var randomTipsName: String     // = strings_tipsShortName[0]
    @Published var randomImageElement: String // = strings_currencySymbols[0]
    @Published var isShowHomeView: Bool = false {
        didSet {
            UserDefaults.standard.setValue(true, forKey: usrDefaults_showHomeView)
        }
    }
    
    init() {
        UserDefaults.standard.setValue("CZK", forKey: usrDefaults_defaultCodeCurrency)
        self.tipsNamed          = strings_tipsShortName
        self.symbols            = strings_currencySymbols
        self.randomTipsName     = strings_tipsShortName[0]
        self.randomImageElement = strings_currencySymbols[0]
    }
    
    public func randomImageAndTipsName() {
        randomTips()
        randomImage()
    }
    
    private func randomTips() {
        self.randomTipsName = tipsNamed.randomElement() ?? strings_tipsShortName[0]
    }
    
    private func randomImage() {
        self.randomImageElement = symbols.randomElement() ?? strings_currencySymbols[0]
    }
}
