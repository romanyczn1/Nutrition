//
//  ViewController.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let dataSource = ViewControllerDataModel()
    
    let headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineChart: LineChart = {
        let lineChart = LineChart()
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        return lineChart
    }()
    
//    let lineChartView: LineChartView = {
//        let view = LineChartView(custom: true)
//        view.isUserInteractionEnabled = false
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 108, height: 166)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(EatingCell.self, forCellWithReuseIdentifier: EatingCell.reuseIdentifier)
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateChartData(with: [0, 0, 0])
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.getEatingsData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        view.addSubview(lineChart)
        lineChart.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 150).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: 150).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 150).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func updateChartData(with numbers: [Double]) {
        //        var lineChartEntry = [ChartDataEntry]()
        //        for i in 0..<numbers.count {
        //            let value = ChartDataEntry(x: Double(i), y: numbers[i])
        //            lineChartEntry.append(value)
        //        }
        //        let line1 = LineChartDataSet(entries: lineChartEntry, label: "")
        //        line1.valueFont = UIFont(name: "OpenSans", size: 12)!
        //        line1.valueTextColor = NSUIColor(cgColor: UIColor.gray.cgColor)
        //        line1.lineWidth = 3
        //        line1.setColor(NSUIColor(red: 170/255, green: 243/255, blue: 244/255, alpha: 1))
        //        line1.setCircleColor(NSUIColor(cgColor: UIColor.black.cgColor))
        //        line1.drawCircleHoleEnabled = false
        //        line1.circleRadius = 3.32
        //        line1.mode = .horizontalBezier
        //        let data = LineChartData()
        //        data.addDataSet(line1)
        //        lineChartView.data = data
        
        //        lineChart.dataEntries = numbers.map({ (number) -> PointEntry in
        //            return PointEntry(value: Int(number), label: "\(number)")
        //        })
        
        var kek: [PointEntry] = []
        numbers.forEach { (number) in
            let entry = PointEntry(value: Int(number), label: "\(number)")
            kek.append(entry)
        }
        lineChart.dataEntries = kek
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EatingCell.reuseIdentifier, for: indexPath) as? EatingCell{
            cell.delegate = self
            cell.configureWithItem(item: dataSource.getItem(for: indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: ViewControllerDataModelDelegate {
    
    func updateViews(eating: Int, total: Int, graphNumbers: [Double]) {
        collectionView.reloadData()
        updateChartData(with: graphNumbers)
        headerView.eatingValueLabel.text = "\(eating)"
        headerView.totalValueLabel.text = "\(total)"
    }
    
    
}

extension ViewController: EatingCellDelegate {
    func addKcals(for eatingType: EatingType) {
        let title: String
        switch eatingType {
        case .breakfast:
            title = "Breakfast"
        case .lunch:
            title = "Lunch"
        case .dinner:
            title = "Dinner"
        }
        let alert = UIAlertController(title: title, message: "Enter number of kcals", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0]
            if let kcal = Int((textField?.text)!) {
                if kcal < 10000 {
                    dataSource.addKcals(for: eatingType, kcals: kcal)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

