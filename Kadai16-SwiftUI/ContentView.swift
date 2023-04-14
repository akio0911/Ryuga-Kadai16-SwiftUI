//
//  ContentView.swift
//  Kadai16-SwiftUI
//
//  Created by Ryuga on 2023/04/14.
//

import SwiftUI

import SwiftUI

struct Fruit: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool
}

struct ContentView: View {
    @State private var showingModal = false
    @State var fruits = [
        Fruit(name: "りんご", isChecked: false),
        Fruit(name: "みかん", isChecked: true),
        Fruit(name: "バナナ", isChecked: false),
        Fruit(name: "パイナップル", isChecked: true)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits.indices, id: \.self) { index in
                    let fruit = fruits[index]
                    ZStack {
                        HStack{
                            Image(systemName: "checkmark")
                                .foregroundColor(fruit.isChecked ? Color.orange : Color.white)
                            Spacer().frame(width: 15)
                            Text(fruit.name)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            fruits[index].isChecked.toggle()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingModal = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .fullScreenCover(isPresented: $showingModal) {
                        AddItemView(
                            didSave: { fruit in
                                fruits.append(fruit)
                                showingModal = false
                            },
                            didCancel: {
                                showingModal = false
                            }
                        )
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

