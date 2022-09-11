//
//  AddView.swift
//  iExpense
//
//  Created by @andreev2k on 10.09.2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Личные"
    @State private var amount: Double? = nil
    
    var arrType = ["Деловые", "Личные", "Развлечения"]
    
    @Environment(\.dismiss) var dismiss
    
    var disabled: Bool {
        name.isEmpty || amount == nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $name)
                
                Picker("Цель расходов", selection: $type) {
                    ForEach(arrType, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Сумма", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "RUB"))
                    .keyboardType(.numberPad)
                
            } .navigationTitle("Добавь расходы")
                .toolbar {
                    Button("Сохранить") {
                        // экземпляр "ExpenseItem" для записи в нее статьи расходов
                        let item = ExpenseItem(type: type, itemses: [Exp.init(name: name, amount: amount ?? 0.0)])
                        expenses.items.append(item)
                        dismiss()
                    } .disabled(disabled)
                }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
