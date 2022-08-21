//
//  CardView.swift
//  PokeTask
//
//  Created by Oğuz Coşkun on 21.08.2022.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var pokemonViewModel: PokemonViewModel
    let width : CGFloat
    let height : CGFloat
    @Binding var horizontalDegree : Double
    @Binding var verticalDegree : Double
    
    init(pokemonId: Int, width : CGFloat, height : CGFloat, horizontalDegree: Binding<Double>, verticalDegree: Binding<Double>) {
        self.pokemonViewModel = PokemonViewModel(pokemonId: pokemonId)
        self.width = width
        self.height = height
        self._horizontalDegree = horizontalDegree
        self._verticalDegree = verticalDegree
    }
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(alignment: .center, spacing: 0) {
                Text(pokemonViewModel.PokemonStat.name.capitalizingFirstLetter())
                    .foregroundColor(.black)
                    .font(Font.custom("SFCompactRounded-Regular", size: 24))
                    .padding(.top, 18)
                
                Spacer()
                
                AsyncImage(
                    url: URL(string: pokemonViewModel.PokemonStat.imageUrl),
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                
                
                HStack(spacing: 0) {
                    let statWidth :CGFloat = isDevicePhone() ? 88 : 176
                    VStack(alignment: .center,spacing: 0) {
                        Text("hp")
                            .font(Font.custom("SFCompactRounded-Regular", size: 18))
                            .frame(width: statWidth, height: 21)
                        Text(String(pokemonViewModel.PokemonStat.hp))
                            .font(Font.custom("SFCompactRounded-Medium", size: 32))
                            .frame(width: statWidth, height: 38)
                    }
                    VStack(alignment: .center,spacing: 0) {
                        Text("attack")
                            .font(Font.custom("SFCompactRounded-Regular", size: 18))
                            .frame(width: statWidth, height: 21)
                        Text(String(pokemonViewModel.PokemonStat.attack))
                            .font(Font.custom("SFCompactRounded-Medium", size: 32))
                            .frame(width: statWidth, height: 38)
                    }
                    VStack(alignment: .center,spacing: 0) {
                        Text("defense")
                            .font(Font.custom("SFCompactRounded-Regular", size: 18))
                            .frame(width: statWidth, height: 21)
                        Text(String(pokemonViewModel.PokemonStat.defense))
                            .font(Font.custom("SFCompactRounded-Medium", size: 32))
                            .frame(width: statWidth, height: 38)
                    }
                }
                .foregroundColor(.black)
                .padding(.horizontal, 18)
                .padding(.bottom, 23)
            }
        }
        .overlay(
            ZStack {
                Color.white
                
                Text("Loading...")
                    .foregroundColor(.black)
                    .font(Font.custom("SFCompactRounded-Regular", size: 24))
                    .fixedSize()
            }
            .frame(width: isDevicePhone() ? 300 : 600, height: 480)
            .cornerRadius(isDevicePhone() ? 36 : 72)
            .opacity(self.pokemonViewModel.statusLoading ? 1 : 0)
        )
        .frame(width: isDevicePhone() ? 300 : 600, height: 480)
        .cornerRadius(isDevicePhone() ? 36 : 72)
        .rotation3DEffect(Angle(degrees: horizontalDegree), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(Angle(degrees: verticalDegree), axis: (x: 1, y: 0, z: 0))
    }
}
