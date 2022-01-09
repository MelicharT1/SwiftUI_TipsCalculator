//
//  SettingViewModel.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import Foundation

// MARK: - SettingViewModel
class SettingViewModel: ObservableObject {
    @Published var defaultTipAmount: Int
    @Published var defaultCodeCodeCurrency: String
    @Published var versionTitle: String
    @Published var authorTitle: String
    let percent: [Int] = strings_precentTypes
    
    init() {
        self.versionTitle              = "Verze aplikace: " + "".returnAppVersion()
        self.authorTitle               = "Autor aplikace: \(strings_authorApp)"
        self.defaultCodeCodeCurrency = UserDefaults.standard.string(forKey: usrDefaults_defaultCodeCurrency)!
        self.defaultTipAmount          = UserDefaults.standard.integer(forKey: usrDefaults_defaultAmountTip)
    }
}

// MARK: - extension SettingViewModel
extension SettingViewModel {
    /// Update tip amount value and userDefaults
    func updateTipAmount(value: Int, userDefaultsName: String) {
        defaultTipAmount = value
        UserDefaults.standard.set(value, forKey: userDefaultsName)
    }
}
