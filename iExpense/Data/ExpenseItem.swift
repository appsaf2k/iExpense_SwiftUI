//
//  ExpenseItem.swift
//  iExpense
//
//  Created by @andreev2k on 10.09.2022.
//

import Foundation

// структура для хранения ОДНОЙ статьи расходов
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let type: String
    var itemses: [Exp]
}

struct Exp: Identifiable, Codable {
    var id = UUID()
    let name: String
    let amount: Double
}
