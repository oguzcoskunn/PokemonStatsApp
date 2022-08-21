//
//  ContentView.swift
//  PokeTask
//
//  Created by Oğuz Coşkun on 19.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State var firstCardPokemonIndex: Int = 1
    @State var secondCardPokemonIndex: Int = 2
    
    @State var frontHorizontalDegree = 0.0
    @State var backHorizontalDegree = -90.0
    
    @State var frontVerticalDegree = 0.0
    @State var backVeritcalDegree = 0.0
    
    @State var isFlipped = false
    
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    var body: some View {
        let buttonSize: CGFloat = isDevicePhone() ? 48 : 72
        let buttonRadius: CGFloat = isDevicePhone() ? 32 : 36
        let buttonIconSize: CGSize = .init(width: isDevicePhone() ? 20.03 : 35.61, height: isDevicePhone() ? 24 : 42.67)
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .center) {
                Color("BackgroundColor")
                
                ZStack {
                    CardView(pokemonId: self.secondCardPokemonIndex, width: width, height: height, horizontalDegree: $backHorizontalDegree, verticalDegree: $backVeritcalDegree)
                    
                    CardView(pokemonId: self.firstCardPokemonIndex, width: width, height: height, horizontalDegree: $frontHorizontalDegree, verticalDegree: $frontVerticalDegree)
                }
                .onTapGesture {
                    flipCard()
                }
            }
            
            Button {
                if isFlipped {
                    flipCard()
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) {
                        firstCardPokemonIndex = 1
                        secondCardPokemonIndex = 2
                    }
                } else {
                    flipCard()
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) {
                        firstCardPokemonIndex = 2
                        secondCardPokemonIndex = 1
                    }
                }
            } label: {
                ZStack {
                    Color.white
                    
                    Image("Shape")
                        .resizable()
                        .frame(width: buttonIconSize.width, height: buttonIconSize.height)
                }
            }
            .frame(width: buttonSize, height: buttonSize)
            .cornerRadius(buttonRadius)
            .padding(.leading, 16)
            .padding(.top, 48)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func flipCard() {
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backVeritcalDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontVerticalDegree = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) {
                secondCardPokemonIndex = firstCardPokemonIndex + 1
                backHorizontalDegree = -90.0
                backVeritcalDegree = 0.0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontHorizontalDegree = 90.0
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backHorizontalDegree = 0.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) {
                firstCardPokemonIndex = secondCardPokemonIndex + 1
                frontHorizontalDegree = 0.0
                frontVerticalDegree = -90.0
            }
        }
        isFlipped.toggle()
    }
}



//Text(pokemonViewModel.PokemonStat.name)
//Text(String(pokemonViewModel.PokemonStat.hp))
//Text(String(pokemonViewModel.PokemonStat.attack))
//Text(String(pokemonViewModel.PokemonStat.defense))
//
//Button {
//    self.currentPokemonIndex += 1
//    pokemonViewModel.getPokemon(with: String(self.currentPokemonIndex))
//} label: {
//    Text("Next")
//}
