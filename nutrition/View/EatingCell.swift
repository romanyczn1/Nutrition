//
//  EatingCell.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import UIKit

protocol EatingCellDelegate: class {
    func addKcals(for eatingType: EatingType)
}

final class EatingCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "EatingCell"
    private var eatingType: EatingType?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                plusButton.isEnabled = true
            } else {
                plusButton.isEnabled = false
            }
            shadowView.changeView(isSelected: isSelected)
        }
    }
    
    weak var delegate: EatingCellDelegate?
    
    let shadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00 am"
        return label
    }()
    
    let kcalsValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.numberOfLines = 2
        return label
    }()
    
    let kcalsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "kcal"
        label.font = UIFont(name: "OpenSans", size: 18)
        label.numberOfLines = 2
        return label
    }()
    
    let eatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BREAKFAST"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        plusButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        delegate?.addKcals(for: eatingType!)
    }
    
    func configureWithItem(item: EatingCellModel) {
        switch item.eatingType {
        case .breakfast:
            self.eatingLabel.text = "BREAKFAST"
        case .lunch:
            self.eatingLabel.text = "LUNCH"
        case .dinner:
            self.eatingLabel.text = "DINNER"
        }
        self.eatingType = item.eatingType
        self.kcalsValueLabel.text = "\(item.kcal)"
        self.timeLabel.text = item.time
    }
    
    private func setUpViews() {
        
        contentView.addSubview(shadowView)
        shadowView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        shadowView.widthAnchor.constraint(greaterThanOrEqualToConstant: 88).isActive = true
        shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        shadowView.addSubview(plusButton)
        plusButton.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 12).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -12).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        shadowView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 15).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 12).isActive = true
        
        shadowView.addSubview(kcalsValueLabel)
        kcalsValueLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15).isActive = true
        kcalsValueLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 12).isActive = true

        shadowView.addSubview(kcalsLabel)
        kcalsLabel.topAnchor.constraint(equalTo: kcalsValueLabel.bottomAnchor, constant: 0).isActive = true
        kcalsLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 12).isActive = true
        
        shadowView.addSubview(eatingLabel)
        eatingLabel.topAnchor.constraint(equalTo: kcalsLabel.bottomAnchor, constant: 15).isActive = true
        eatingLabel.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor).isActive = true
        eatingLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
