//
//  Expenses.swift
//  iExpense
//
//  Created by @andreev2k on 10.09.2022.
//

import Foundation

// "класс расходов", для хранения и загрузки МАССИВА ВСЕХ СТАТЕЙ "ExpenseItem"
class Expenses: ObservableObject {
    let nameItems = "Items"
    
    @Published var items = [ExpenseItem]() {
        // didSet - наблюдатель изменения для свойства "@Published var items"
        didSet {
            // записываем(кодируем) сохраненные данные в корень приложения через items = [ExpenseItem]()
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: nameItems)
            }
        }
    }
    
    init() {
        // преобразуем(декодируем) сохраненные данные из корня приложения
        if let savedItems = UserDefaults.standard.data(forKey: nameItems) {
                                                        // [ExpenseItem].self - self указывает именно на тип массива
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        // если декодирование не получилось, возвращаем пустой массив
        items = []
    }
}
