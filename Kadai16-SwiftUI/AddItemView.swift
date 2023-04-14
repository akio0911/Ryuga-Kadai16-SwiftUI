//
//  AddItemView.swift
//  Kadai16-SwiftUI
//
//  Created by Ryuga on 2023/04/14.
//

import SwiftUI

struct AddItemView: View {
    @State private var newItem = ""
    let didSave: (Fruit) -> Void
    let didCancel: () -> Void

    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Text("名前")
                    TextField("", text: $newItem)
                        .modifier(CustomTextFieldStyle())
                }
                Spacer()
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        didCancel()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        didSave(Fruit(name: newItem, isChecked: false))
                    }
                }
            }
        }
    }
}

struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, alignment: .trailing)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct Preview: View {
    @State var fruits = [Fruit(name: "りんご", isChecked: false)]
    var body: some View {
        AddItemView(didSave: { _ in }, didCancel: {})
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}

