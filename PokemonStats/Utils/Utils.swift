//
//  Extensions.swift
//  PokeTask
//
//  Created by Oğuz Coşkun on 21.08.2022.
//

import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension View {
    func phoneOnlyStackNavigationView() ->some View{

        if UIDevice.current.userInterfaceIdiom == .phone{
            return AnyView(self)
        }else{
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}

func isDevicePhone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}
