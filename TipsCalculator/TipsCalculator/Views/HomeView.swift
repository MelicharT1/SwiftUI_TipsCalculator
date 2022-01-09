//
//  ContentView.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 02.01.2022.
//

import SwiftUI

// MARK: - HomeView
struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    private let personSymbol: String       = "person.2"
    private let hideKeyboardSymbol: String = "keyboard.chevron.compact.down"
    private let settingSymbols: [String]   = ["gearshape.fill", "gearshape"]
    private let clearSymbols: [String]     = ["delete.backward.fill", "delete.backward"]
    
    var body: some View {
        NavigationView {
                VStack {
                    // header
                    
                    headerLayer
                    // formLayer
                    formLayer
                        .shadow(color: .secondary, radius: 3)
                }//: VStack
            .navigationBarItems(trailing:
            HStack {
                /// Setting button
                Button {
                    homeViewModel.isShowSettingView.toggle()
                } label: {
                    Image(systemName: homeViewModel.isShowSettingView ? settingSymbols[0] : settingSymbols[1])
                }//: Button (settings)
                /// Hide keyboard
                Button {
                    self.hideKeyboard()
                } label: {
                    Image(systemName: hideKeyboardSymbol)
                }//: Button (settings)
                /// Clear button
                Button {
                    homeViewModel.setDefault()
                } label: {
                    Image(systemName: ((Double(homeViewModel.sumBill) ?? 0) > 0) ? clearSymbols[0] : clearSymbols[1])
                }//: Button (remove)
            }//: HStack
                .tint(Color.secondary)
            )//:navigationBarItems
        }//: NavigationView
        .sheet(isPresented: $homeViewModel.isShowSettingView) {
            SettingView()
                .environmentObject(homeViewModel)
        }//: sheet
    }//: body View
    
    /// headerLayer
    private var headerLayer: some View {
        VStack {
            /// Large title
            // TODO: currency
            Text((homeViewModel.sumBillValue), format: .currency(code: homeViewModel.currencyCodeSymbol))
                .font(.largeTitle)
                .bold()
                .padding([.bottom, .leading, .trailing], 3)
            /// Global detail
            HeaderDetailView(sumBillValue: $homeViewModel.sumBillValue, currencyCodeSymbol: $homeViewModel.currencyCodeSymbol, sumTipsValue: $homeViewModel.sumTipsValue)
             
            // by user
            if (Double(homeViewModel.sumBill) ?? 0) > 0 && homeViewModel.countOfPerson > 1 {
                VStack {
                    /// Person detail with image
                    HStack {
                        Image(systemName: personSymbol)
                        Text("\(homeViewModel.countOfPerson)x")
                    }//: HStack
                    .foregroundColor(.secondary)
                    /// Person detail information
                    HeaderDetailView(sumBillValue: $homeViewModel.sumBillByUserValue, currencyCodeSymbol: $homeViewModel.currencyCodeSymbol, sumTipsValue: $homeViewModel.sumTipsByUserValue)
                }//: VStack
                //.padding(.top, 3)
            }//: if
        }//: VStack (Header)
    }//: headerLayer
    
    /// formLayer
    private var formLayer: some View {
        Form {
            Section (header: Text("#1 Celkem k úhradě"), footer: Text("Zadejte celou částku, neřešíme drobné")) {
                HStack {
                    // TODO: currency
                    Text(homeViewModel.currencyCodeSymbol)
                        .font(.headline)
                    TextField("Input value", text: $homeViewModel.sumBill, prompt: Text("0.00"))
                        .keyboardType(.numberPad)
                    .padding()
                }//: HStack
            }//: Section (Sum)
            
            Section (header: Text("#2 Počet platících osob")) {
                Stepper("\(homeViewModel.countOfPerson)", value: $homeViewModel.countOfPerson, in: 1...100)
                    .font(.headline)
                    .padding()
            }//: Section (Person)
            
            Section (header: Text("#3 Výše spropitného (%)")) {
                HStack {
                    Text("\(homeViewModel.percentType)")
                    Image(systemName: "percent")
                        .accentColor(Color.secondary)
                }//: HStack
                .padding()
                .contextMenu(
                    menuItems: {
                        ForEach(homeViewModel.percent, id: \.self) { item in
                            Button {
                                homeViewModel.percentType = Int(item)
                            } label: {
                                Text("\(item)")
                            }//:Button (label)
                        }//: ForEach
                    }//: menuItems
                )//: contextMenu
            }//: Section (Percent)
        }//: Form
    }//: FormLayer
}//: HomeView

// MARK: - HeaderDetailView
private struct HeaderDetailView: View {
    @Binding var sumBillValue: Double
    @Binding var currencyCodeSymbol: String
    @Binding var sumTipsValue: Double
    private let separatorSymbol: String      = "|"
    private let defaultSpacingValue: CGFloat = 0
    
    var body: some View {
        HStack {
            HStack (spacing: defaultSpacingValue) {
                Text("Bill: ")
                Text(sumBillValue, format: .currency(code: currencyCodeSymbol))
            }//: HStack
                .font(.footnote)
            Text(separatorSymbol)
            HStack (spacing: defaultSpacingValue) {
                Text("Tips: ")
                Text((sumTipsValue), format: .currency(code: currencyCodeSymbol))
            }//: HStack
            .font(.footnote)
        }//: HStack
    }
}

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
