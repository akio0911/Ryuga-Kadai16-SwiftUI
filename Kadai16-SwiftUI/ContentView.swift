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
    @State var fruits = [
        Fruit(name: "りんご", isChecked: false),
        Fruit(name: "みかん", isChecked: true),
        Fruit(name: "バナナ", isChecked: false),
        Fruit(name: "パイナップル", isChecked: true)
    ]

    @State private var editMode: AddItemView.Mode?

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
                        HStack {
                            Spacer()
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.blue)
                        }
                        .onTapGesture {
                            editMode = .update(
                                fruit: fruits[index],
                                didSave: {
                                    fruits[index] = $0
                                    editMode = nil
                                },
                                didCancel: {
                                    editMode = nil
                                }
                            )
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editMode = .create(
                            didSave: {
                                fruits.append($0)
                                editMode = nil
                            },
                            didCancel: {
                                editMode = nil
                            }
                        )
                    }) {
                        Image(systemName: "plus")
                    }
                    .fullScreenCover(item: $editMode) { mode in
                        AddItemView(mode: mode)
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

