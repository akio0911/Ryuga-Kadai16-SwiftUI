//
//  AddItemView.swift
//  Kadai16-SwiftUI
//
//  Created by Ryuga on 2023/04/14.
//

import SwiftUI

struct AddItemView: View {
    enum Mode {
        case create(didSave: (Fruit) -> Void, didCancel: () -> Void)
        case update(fruit: Fruit, didSave: (Fruit) -> Void, didCancel: () -> Void)
    }

    @State var name: String = ""

    let mode: Mode

    init(mode: Mode) {
        self.mode = mode

        switch mode {
        case .create:
            name = ""
        case let .update(fruit: fruit, didSave: _, didCancel: _):
            name = fruit.name
        }
    }

    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Text("名前")
                    TextField("", text: $name)
                        .modifier(CustomTextFieldStyle())
                }
                Spacer()
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        switch mode {
                        case let .create(didSave: _, didCancel: didCancel):
                            didCancel()
                        case let .update(fruit: _, didSave: _, didCancel: didCancel):
                            didCancel()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        switch mode {
                        case let .create(didSave: didSave, didCancel: _):
                            didSave(Fruit(name: name, isChecked: false))
                        case let .update(fruit: fruit, didSave: didSave, didCancel: _):
                            didSave(Fruit(name: name, isChecked: fruit.isChecked))
                        }
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
    @State var newItem = "りんご"
    @State var fruits = [Fruit(name: "りんご", isChecked: false)]
    var body: some View {
        AddItemView(mode: .create(didSave: { _ in }, didCancel: {}))
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}

