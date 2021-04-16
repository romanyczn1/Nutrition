//
//  HeaderView.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import UIKit

struct Constants {
    static let goal = 1450
    static let burnt = 90
}

final class HeaderView: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Nutrition"
        label.font = UIFont(name: "OpenSans-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.goal) kcal"
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eatingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0 kcal"
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let burntValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.burnt) kcal"
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 13)
        label.text = "Calories Goal:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 13)
        label.text = "Eating:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let burntLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 13)
        label.text = "Burnt:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 13)
        label.text = "Total:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 48)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalKcalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.text = "kcal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        setUpViews()
    }
    
    private func setUpViews() {
        addSubview(mainLabel)
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        addSubview(goalsLabel)
        goalsLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor).isActive = true
        goalsLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 18).isActive = true
        addSubview(eatingLabel)
        eatingLabel.topAnchor.constraint(equalTo: goalsLabel.bottomAnchor, constant: 10).isActive = true
        eatingLabel.leadingAnchor.constraint(equalTo: goalsLabel.leadingAnchor).isActive = true
        addSubview(burntLabel)
        burntLabel.topAnchor.constraint(equalTo: eatingLabel.bottomAnchor, constant: 10).isActive = true
        burntLabel.leadingAnchor.constraint(equalTo: goalsLabel.leadingAnchor).isActive = true
        
        addSubview(goalsValueLabel)
        goalsValueLabel.leadingAnchor.constraint(equalTo: goalsLabel.trailingAnchor, constant: 10).isActive = true
        goalsValueLabel.centerYAnchor.constraint(equalTo: goalsLabel.centerYAnchor, constant: 0).isActive = true
        addSubview(eatingValueLabel)
        eatingValueLabel.leadingAnchor.constraint(equalTo: goalsValueLabel.leadingAnchor, constant: 0).isActive = true
        eatingValueLabel.centerYAnchor.constraint(equalTo: eatingLabel.centerYAnchor, constant: 0).isActive = true
        addSubview(burntValueLabel)
        burntValueLabel.leadingAnchor.constraint(equalTo: goalsValueLabel.leadingAnchor, constant: 0).isActive = true
        burntValueLabel.centerYAnchor.constraint(equalTo: burntLabel.centerYAnchor, constant: 0).isActive = true
        burntLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(totalLabel)
        totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        totalLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 18).isActive = true
        addSubview(totalValueLabel)
        totalValueLabel.trailingAnchor.constraint(equalTo: totalLabel.trailingAnchor).isActive = true
        totalValueLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor).isActive = true
        addSubview(totalKcalLabel)
        totalKcalLabel.trailingAnchor.constraint(equalTo: totalLabel.trailingAnchor).isActive = true
        totalKcalLabel.topAnchor.constraint(equalTo: totalValueLabel.bottomAnchor, constant: -8).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
