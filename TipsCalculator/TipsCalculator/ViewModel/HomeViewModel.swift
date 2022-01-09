//
//  HomeViewModel.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import SwiftUI

// MARK: - HomeViewModel
class HomeViewModel: ObservableObject {
    let percent: [Int]                = strings_precentTypes
    @Published var isShowSettingView: Bool = false /// Bool value for show settingView
    /// počet osob
    @Published var countOfPerson: Int = 1 {
        didSet {
            updateSumBillAndTip()
        }
    }
    /// Vychozi hodnota pro kod země  (např. czk)
    @Published var currencyCodeSymbol: String = UserDefaults.standard.string(forKey: usrDefaults_defaultCodeCurrency) ?? "CZK" 
    @Published var percentType: Int   = UserDefaults.standard.integer(forKey: usrDefaults_defaultAmountTip) {
        didSet {
            updateSumBillAndTip()
        }
    }
    
    @Published var sumBillValue: Double = 0
    @Published var sumTipsValue: Double = 0
    /// by user
    @Published var sumBillByUserValue: Double = 0
    @Published var sumTipsByUserValue: Double = 0
    
    @Published var sumBill = "" {
        didSet {
            let validateValue = sumBill.filter {$0.isNumber}
            
            if sumBill != validateValue {
                sumBill = validateValue
            }//: if
            updateSumBillAndTip()
        }//: didSet
    }
}

// MARK: - extension HomeViewModel
extension HomeViewModel {
    func updateSumBillAndTip() {
        sumBillValue = calcSumBillWithTips()
        sumTipsValue = calcTips()
        sumBillByUserValue = calcBillByUser()
        sumTipsByUserValue = calcTipsByUser()
    }
    
    func updatePercentType(value: Int) {
        self.percentType = value
    }
    
    func updateCurrencySymbol(value: String) {
        self.currencyCodeSymbol = value
    }
    
    func setDefault() {
        countOfPerson = 1
        sumBill       = ""
        percentType   = UserDefaults.standard.integer(forKey: usrDefaults_defaultAmountTip)
    }
    
    private func calcSumBillWithTips() -> Double {
        let sumTips = calcTips()
        return sumTips + (Double(sumBill) ?? 0)
    }
    
    private func calcTips() -> Double {
        let onePercent = (Double(sumBill) ?? 0) / Double(100)
        let sumTips    = onePercent * Double(percentType)
        return sumTips
    }
    
    private func calcBillByUser() -> Double {
        let sumBillWithTips = (Double(sumBill) ?? 0) / Double(countOfPerson)
        return sumBillWithTips
    }
    
    private func calcTipsByUser() -> Double {
        let sumTips = calcTips() / Double(countOfPerson)
        return sumTips
    }
}
