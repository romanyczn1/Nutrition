//
//  LineChart.swift
//  nutrition
//
//  Created by Roman Bukh on 16.04.21.
//

import UIKit

struct PointEntry {
    let value: Int
    let label: String
}

extension PointEntry: Comparable {
    static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value
    }
}

class LineChart: UIView {
    
    /// gap between each point
    var lineGap: CGFloat = 165.0
    
    /// preseved space at top of the chart
    let topSpace: CGFloat = 40.0
    
    /// preserved space at bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 40.0
    
    /// The top most horizontal line in the chart will be 10% higher than the highest value in the chart
    let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    /// Dot inner Radius
    var innerRadius: CGFloat = 8

    /// Dot outer Radius
    var outerRadius: CGFloat = 12
    
    var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// Contains the main line which represents the data
    private let dataLayer: CALayer = CALayer()
    
    /// Contains dataLayer and gradientLayer
    private let mainLayer: CALayer = CALayer()
    
    /// An array of CGPoint on dataLayer coordinate system that the main line will go through. These points will be calculated from dataEntries array
    private var dataPoints: [CGPoint]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
//        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        self.layer.addSublayer(mainLayer)
    }
    
    override func layoutSubviews() {
        if let dataEntries = dataEntries {
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
//            drawDots()
            clean()
            drawCurvedChart()
//            drawLables()
        }
    }
    
    /**
     Convert an array of PointEntry to an array of CGPoint on dataLayer coordinate system
     */
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        if let max = entries.max()?.value,
            let min = entries.min()?.value {
            var result: [CGPoint] = []
            var minMaxRange: CGFloat = CGFloat(max - min) * topHorizontalLine
            if minMaxRange == 0 {
                minMaxRange = dataLayer.frame.height
            }
            for i in 0..<entries.count {
                let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
                let point = CGPoint(x: CGFloat(i)*lineGap + 40, y: height)
                result.append(point)
            }
//            result.forEach { (point) in
//                print("x: \(point.x) y: \(point.y)")
//            }
            return result
        }
        return []
    }
    
    /**
     Draw a curved line connecting all points in dataPoints
     */
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.lineWidth = 3
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = hexStringToUIColor(hex: "#94F5F5").cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    /**
     Create titles at the bottom for all entries showed in the chart
     */
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            for i in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size.height - bottomSpace/2 - 8, width: lineGap, height: 16)
                textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 11
                textLayer.string = dataEntries[i].label
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    /**
     Create Dots on line points
     */
    private func drawDots() {
        var dotLayers: [DotCALayer] = []
        if let dataPoints = dataPoints {
            for dataPoint in dataPoints {
                let xValue = dataPoint.x - outerRadius/2
                let yValue = (dataPoint.y + lineGap) - (outerRadius * 2)
//                print("dot x: \(xValue)  y: \(yValue)" )
                let dotLayer = DotCALayer()
//                dotLayer.dotInnerColor = UIColor.black
//                dotLayer.innerRadius = innerRadius
                dotLayer.backgroundColor = UIColor.white.cgColor
                dotLayer.cornerRadius = outerRadius / 2
                dotLayer.frame = CGRect(x: xValue, y: yValue-105, width: outerRadius, height: outerRadius)
                dotLayers.append(dotLayer)

                mainLayer.addSublayer(dotLayer)
            }
        }
    }
    
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
