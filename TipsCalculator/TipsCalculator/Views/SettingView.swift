//
//  SettingView.swift
//  TipsCalculator
//
//  Created by Tomáš Melichar on 03.01.2022.
//

import SwiftUI

// TODO: Neauktuluje se hodnota měny jako u %

// MARK: - Enums
fileprivate enum FormSectionType {
    case tipAmount
    case footer
}

// MARK: - SettingView
struct SettingView: View {
    @StateObject var settingViewModel: SettingViewModel = SettingViewModel()
    @EnvironmentObject var homeVM: HomeViewModel
    private let selectedSymbols: [String] = ["circle.fill", "circle"]
    
    var body: some View {
        VStack {
            Text("Nastavení")
                .font(.largeTitle)
                .bold()
                .padding(.top, 5)
            
            formLayer
                .shadow(color: .secondary, radius: 4)
        }//: VStack
    }//: body
    
    private var formLayer: some View {
        Form {
            // #1 Výchozí % dýška
            /// Popis: Binding ori main a second title je stejný, neboť další text je zobrazen pouze pro footer
            FooterSectionView(formSectionType: .tipAmount,
                              mainTitle: $settingViewModel.defaultCodeCodeCurrency,
                              secondFooterTitle: $settingViewModel.defaultCodeCodeCurrency, tipAmountTitle: $settingViewModel.defaultTipAmount,
                              headerTitle: "Výchozí sazba spropitného v %"
            )//: FooterSectionView
            .contextMenu(
                menuItems: {
                    ForEach(settingViewModel.percent, id: \.self) { item in
                        Button {
                            homeVM.updatePercentType(value: item)
                            
                            settingViewModel.updateTipAmount(value: item, userDefaultsName: usrDefaults_defaultAmountTip)
                        } label: {
                            Label("\(item) %", systemImage: (item == settingViewModel.defaultTipAmount) ? selectedSymbols[0] : selectedSymbols[1])
                        }//:Button (label)
                    }//: ForEach
                }//: menuItems
            )//: contextMenu
            
            // #3 Footer: Version and author
            FooterSectionView(formSectionType: .footer,
                              mainTitle: $settingViewModel.versionTitle,
                              secondFooterTitle: $settingViewModel.authorTitle, tipAmountTitle: $settingViewModel.defaultTipAmount,
                              headerTitle: "Informace o aplikaci"
            )//: FooterSectionView
        }//: Form
    }//: formLayer some View
}//: SettingView

// MARK: - FooterSectionView
private struct FooterSectionView: View {
    @State var formSectionType: FormSectionType
    @Binding var mainTitle: String
    @Binding var secondFooterTitle: String
    @Binding var tipAmountTitle: Int
    let headerTitle: String
    
    var body: some View {
        Section (header: Text(headerTitle)) {
            VStack (alignment: .center, spacing: 5) {
                Text((formSectionType != .tipAmount) ? mainTitle : "\(tipAmountTitle)")
                if formSectionType == .footer {
                    Text(secondFooterTitle)
                }
            }//: VStack
            .modifier(SettingSectionViewModifier(formSectionType: formSectionType))
        }//: Section (version and author)
    }//: body some View
}//: FooterSectionView

// MARK: SettingSectionViewModifier
private struct SettingSectionViewModifier: ViewModifier {
    @State var formSectionType: FormSectionType
    private let minFrameValue: CGFloat = 0
    
    func body(content: Content) -> some View {
            content
            .foregroundColor((formSectionType == .footer) ? .secondary : .primary)
            .font((formSectionType == .footer) ? .footnote : .title2 )
                .frame(minWidth: minFrameValue,
                       maxWidth: .infinity,
                       minHeight: minFrameValue,
                       maxHeight: .infinity
                )//: frame
        }//: func
}//: SettingSectionViewModifier

// MARK: - SettingView_Previews
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.light)
    }
}
