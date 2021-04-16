//
//  EatingCellModel.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

enum EatingType: Int {
    case breakfast
    case lunch
    case dinner
}

class EatingCellModel {
    var eatingType: EatingType
    var kcal: Int
    var time: String
    
    init(eatingType: EatingType, kcal: Int, time: String) {
        self.eatingType = eatingType
        self.kcal = kcal
        self.time = time
    }
}
