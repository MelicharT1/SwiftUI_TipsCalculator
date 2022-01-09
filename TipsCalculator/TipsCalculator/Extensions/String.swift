//
//  String.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import Foundation

extension String {
    /*
    /// Function for return currency symbol
    /// - Parameter code: IDS currency code 
    /// - Returns: Optional string as currency symbol
    func getCurrencySymbol(forCurrencyCode code: String) -> String {
       let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code) ?? "$"
    }
    */
    
    /// Return actual version and build app
    /// - Returns: Current version app as String
    public func returnAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version    = dictionary["CFBundleShortVersionString"] as! String
        let build      = dictionary["CFBundleVersion"] as! String
        return "\(version) (\(build))"
    }
}
