//
//  ContentView.swift
//  Kav_SkeletonView
//
//  Created by Neil Chan on 2025/5/21.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true
    @State var cards: [Card] = []
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 15) {
                if cards.isEmpty {
                    ForEach(0..<3) { _ in
                        SomeCardView()
                    }
                    
                } else {
                    ForEach(cards) { card in
                        SomeCardView(card: card)
                    }
                }
                
                
                
                Spacer()
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}
struct Card: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    var subTitle: String
    var description: String
}

struct SomeCardView: View {
    var card: Card?
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    if let card {
                        Image(card.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        SkeletonView(.rect)
                    }
                }
                .frame(height: 220)
                .clipped()
            
            VStack(alignment: .leading, spacing: 10) {
                if let card {
                    Text(card.title)
                        .fontWeight(.semibold)
                } else {
                    SkeletonView(.rect(cornerRadius: 5))
                        .frame(height: 20)
                }
                
                Group {
                    if let card {
                        Text(card.subTitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    } else {
                        SkeletonView(.rect(cornerRadius: 5))
                            .frame(height: 15)
                    }
                }
                .padding(.trailing, 30)
                
                ZStack {
                    if let card {
                        Text(card.description)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    } else {
                        SkeletonView(.rect(cornerRadius: 5))
                    }
                }
                .frame(height: 50)
                .lineLimit(3)
            }
            .padding([.horizontal, .top], 15)
            .padding(.bottom, 25)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

#Preview {
    ContentView()
}
