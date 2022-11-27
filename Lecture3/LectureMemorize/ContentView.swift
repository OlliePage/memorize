//
//  ContentView.swift
//  LectureMemorize
//
//  Created by sun on 2021/09/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in // bag of lego View!
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                            .foregroundColor(viewModel.themeColor)
                    }
                }
            }
            .foregroundColor(.blue)
            .padding(.horizontal)
            
            Spacer()
            Button {
                viewModel.restartGame()
            } label : {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxHeight: 80)
                        .padding(.all)
                        .foregroundColor(.purple)
                    HStack {
                        VStack {
                            Text("NEW GAME")
                            Text("Current Theme: \(EmojiMemoryGame.theme.supportedTheme)")
                                .font(.subheadline)
                        }
                        Text(" || Score \(viewModel.score)")
                            .font(.subheadline)
                    }
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.all)
                }
                    
            }
        }
    }
}


struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
