//
//  CommonModel.swift
//  W4-Project1-Gumi
//
//  Created by Thành Nguyên on 05/04/2021.
//

import UIKit

class Item {
    
    var thumbnail = ""
    var name = ""
    var price = 0.0
    var amount = 0
    var backgroundColor = UIColor.white
    
    init(thumbnail: String, name: String, price: Double) {
        self.thumbnail = thumbnail
        self.name = name
        self.price = price
    }
    
    init(thumbnail: String, name: String, price: Double, backgroundColor: UIColor) {
        self.thumbnail = thumbnail
        self.name = name
        self.price = price
        self.backgroundColor = backgroundColor
    }
    
    func increase() {
        self.amount += 1
    }
    
    func reduce() -> Bool {
        if (self.amount > 0){
            self.amount -= 1
            return true
        } else {
            return false
        }
    }
}
