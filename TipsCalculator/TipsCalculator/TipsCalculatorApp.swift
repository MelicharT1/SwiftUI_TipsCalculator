//
//  TipsCalculatorApp.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 02.01.2022.
//

import SwiftUI

@main
struct TipsCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: usrDefaults_showHomeView) {
                HomeView()
            }else {
                OnboardingView()
            }//: if else
        }//: WindowGroup
    }//: body some Scene
}//: TipsCalculatorApp
