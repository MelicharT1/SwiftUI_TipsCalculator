//
//  Strings.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import Foundation

/*
 * Bear in mind not every currency have a corresponding symbol.
 *
 * EXAMPLE TABLE
 *
 * currency code | Country & Currency | Currency Symbol
 *      BGN      |   Bulgarian lev    |      лв
 *      HRK      |   Croatian Kuna    |      kn
 *      CZK      |   Czech  Koruna    |      Kč
 *      EUR      |       EU Euro      |      €
 *      USD      |     US Dollar      |      $
 *      GBP      |   British Pound    |      £
 */
let strings_authorApp: String         = "Tomáš Melichar"
let strings_precentTypes: [Int]       = [0, 5, 10, 15, 20, 30]
let strings_tipsShortName: [String]   = ["tips", "spropitné", "dýško", "diškrece"]
let strings_currencySymbols: [String] = ["dollarsign.circle", "yensign.circle", "sterlingsign.circle", "eurosign.circle", "indianrupeesign.circle", "lirasign.circle", "bitcoinsign.circle"]

// MARK: - UserDefaults
let usrDefaults_showHomeView          = "userDefaultsShowHomeView"
let usrDefaults_defaultAmountTip      = "userDefaultsAmountTip"
let usrDefaults_defaultCodeCurrency   = "userDefaultsCodeCurrency"
