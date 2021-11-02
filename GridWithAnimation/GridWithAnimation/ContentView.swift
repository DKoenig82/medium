//
//  ContentView.swift
//  GridWithAnimation
//
//  Created by David Koenig on 02.11.21.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace var namespace
    @State private var selectedEmoji: String?
    
    let emojis = ["😜", "🤣", "😇", "🥰", "😎", "🧐", "🥳", "😋", "🤪"]
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemTeal).ignoresSafeArea()
                VStack {
                    if selectedEmoji == nil {
                        LazyVGrid(columns: columns, content: {
                            
                            ForEach(emojis, id: \.self) { emoji in
                                Text(emoji)
                                    .font(.system(size: 40))
                                    .padding()
                                    .matchedGeometryEffect(id: emoji, in: namespace)
                                    .onTapGesture {
                                        selectedEmoji = emoji
                                    }
                            }
                        }).animation(.spring())
                    } else if let selectedEmoji = selectedEmoji {
                        Text(selectedEmoji)
                            .matchedGeometryEffect(id: selectedEmoji, in: namespace)
                            .font(.system(size: 70))
                            .onTapGesture {
                                withAnimation {
                                    self.selectedEmoji = nil
                                }
                            }.animation(.spring())
                        Spacer()
                    }
                }.navigationTitle("Grid with Animation")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
