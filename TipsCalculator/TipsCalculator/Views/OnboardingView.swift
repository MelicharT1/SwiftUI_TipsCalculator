//
//  OnboardingView.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import SwiftUI

// MARK: - OnboardingView
struct OnboardingView: View {
    @StateObject private var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    private let bgColor: Color = Color.white
    private let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            Rectangle()
                .fill(Color.black)
                .cornerRadius(30)
                .frame(
                    width: UIScreen.main.bounds.width - 80,
                    height: UIScreen.main.bounds.height - 100
                )//: Rectangle
            
            VStack {
                headerLayer
                
                Spacer()
                
                Button {
                    //UserDefaults.standard.setValue(true, forKey: usrDefaults_showHomeView)
                    onboardingViewModel.isShowHomeView.toggle()
                } label: {
                    Text("Začínáme")
                        .foregroundColor(.white)
                        .font(.title3)
                        .underline(true, color: Color.red)
                        .padding()
                        .frame(width: 250, height: 50)
                        //.border(Color.white, width: 2)
                }//: Button (label)
                .offset(y: -40)
            }//: VStack
        }//: ZStack
        .fullScreenCover(isPresented: $onboardingViewModel.isShowHomeView) {
            HomeView()
        }//: fullScreenCover
    }//: body View
    
    private var headerLayer: some View {
        VStack (spacing: 50){
            Image(systemName: onboardingViewModel.randomImageElement)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 150, height: 150)
            
            Text(onboardingViewModel.randomTipsName)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }//: VStack
        .onReceive(timer) { _ in
            onboardingViewModel.randomImageAndTipsName()
        }//: onReceive (for random elemnt)
    }//: headerLayer some View
}//: OnboardingView

// MARK: - OnboardingView_Previews
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .preferredColorScheme(.dark)
    }
}
