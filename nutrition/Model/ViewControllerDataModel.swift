//
//  ViewControllerDataModel.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import Foundation

protocol ViewControllerDataModelDelegate: class {
    func updateViews(eating: Int, total: Int, graphNumbers: [Double])
}

final class ViewControllerDataModel {
    
    var delegate: ViewControllerDataModelDelegate?
    private var data = [EatingCellModel]()
    
    public func getEatingsData() {
        for i in 0..<3 {
            let itemType = EatingType.init(rawValue: i)!
            let time = "00:00 am"
            let kcal = 0
            let item = EatingCellModel(eatingType: itemType, kcal: kcal, time: time)
            data.append(item)
        }
    }
    
    public func addKcals(for editingType: EatingType, kcals: Int) {
        data[editingType.rawValue].kcal += kcals
        var numbers: [Double] = []
        let date = Date()
        let dtf = DateFormatter()
        dtf.dateFormat = "hh:mm a"
        dtf.amSymbol = "am"
        dtf.pmSymbol = "pm"
        data[editingType.rawValue].time = dtf.string(from: date)
        var eatings = 0
        data.forEach { (eating) in
            eatings += eating.kcal
            numbers.append(0)
            numbers.append(Double(eating.kcal))
            numbers.append(0)
        }
        let total = eatings - Constants.burnt
        delegate?.updateViews(eating: eatings, total: total, graphNumbers: numbers)
    }
    
    public func getItem(for index: Int) -> EatingCellModel{
        return data[index]
    }
    
    public func getItemsCount() -> Int{
        return 3
    }
}
