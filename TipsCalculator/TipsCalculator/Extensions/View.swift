//
//  View.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 06.01.2022.
//

import SwiftUI

extension View {
    /// Extension func for hide keyboard
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
