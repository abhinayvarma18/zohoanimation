//
//  GraphHandler.swift
//  ZohoApp
//
//  Created by ABHINAY on 06/04/18.
//  Copyright © 2018 ABHINAY. All rights reserved.
//

import UIKit
import Charts

class GraphHandler: NSObject {
    
    static let sharedHandler = GraphHandler()
    var markedPoint:ChartDataEntry?
    var dataSet:LineChartDataSet?
    var pointsArray:[ChartDataEntry]?
    //MARK:UI for graph
    //loading basic chart data for axis and font color and ui of graph
    func loadChartData(_ mapView:LineChartView, _ completion: @escaping ()->()) {
        mapView.chartDescription?.enabled = false
        mapView.dragEnabled = true
        mapView.setScaleEnabled(true)
        mapView.pinchZoomEnabled = true
        mapView.noDataText = ""
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 12.0,label: "")
        llXAxis.lineWidth = 2.0
        llXAxis.lineColor = Colors.graphLabelColor
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = Fonts.getBoldFontWithSize(15.0)
        
        
        let xAxis = mapView.xAxis
        xAxis.removeAllLimitLines()
        xAxis.labelPosition = .bottom
        xAxis.addLimitLine(llXAxis)
        xAxis.drawGridLinesEnabled = false
        xAxis.labelCount = 6
        xAxis.labelTextColor = Colors.graphLabelColor
        xAxis.valueFormatter = DayAxisValueFormatter(chart: mapView)
        xAxis.axisMaximum = 30
        xAxis.axisMinimum = 0
        
        // y-axis limit line
        let ll2 = ChartLimitLine(limit: 0, label: "")
        ll2.lineWidth = 2.0
        ll2.lineColor = Colors.graphLabelColor
        ll2.labelPosition = .rightBottom
        ll2.valueFont = Fonts.getBoldFontWithSize(15.0)
        
        let leftAxis = mapView.leftAxis
        
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll2)
        leftAxis.labelCount = 4
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.labelTextColor = Colors.graphLabelColor
        leftAxis.axisMaximum = 20
        leftAxis.axisMinimum = 0
        
        mapView.rightAxis.enabled = false
        
        mapView.legend.form = .line
        completion()
    }
    
    //MARK:Drawing points over graph
    func drawGraphWithPoints(_ points: [CGPoint], range: UInt32, mapView:LineChartView) {
        pointsArray = (0..<points.count).map { (point) -> ChartDataEntry in
            if points[point].x == 12.0 {
                markedPoint = ChartDataEntry.init(x: Double(points[point].x), y: Double(points[point].y), icon:self.textToImage(drawText: "0", inImage: #imageLiteral(resourceName: "blackDot"), atPoint: CGPoint(x: 7, y: 6)))
                return markedPoint!
            }
            return ChartDataEntry.init(x: Double(points[point].x), y: Double(points[point].y))
        }
        
        dataSet = LineChartDataSet(values: pointsArray, label: "")
        //set1.drawIconsEnabled = false
        
        dataSet?.setColor(Colors.greenBlueColor)
        dataSet?.lineWidth = 3.0
        dataSet?.circleRadius = 0.0
        dataSet?.mode = .cubicBezier
        dataSet?.valueFont = .systemFont(ofSize: 0)
        
        dataSet?.formLineDashLengths = [6, 2.5]
        dataSet?.formLineWidth = 1
        dataSet?.formSize = 15
        
        let gradientColors = [Colors.blackBGColor.cgColor,
                              Colors.greenBlueColor.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        dataSet?.fillAlpha = 1
        dataSet?.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        dataSet?.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: dataSet)
        
        mapView.data = data
    }
    
    //MARK:Graph Animation and de-Animation of drawn part
    func animatePlantView(_ mapView:LineChartView) {
        mapView.animate(yAxisDuration: 1.2) { (first, second) -> Double in
            self.updateMarkedPointText(Int(first * 10), mapView)
            return (first > 1.0 ? 1.0 : first)
        }
    }
    
    func deanimatePlantView(_ mapView:LineChartView) {
        mapView.animate(yAxisDuration: 1.2) {(first,second) -> Double in
            self.updateMarkedPointText(Int((1.2-first) * 10), mapView)
            return (first > 1.0 ? 0.0 : 1.0 - first)
        }
    }
    
    //MARK:Rendering Image With new dynamic text
    //dynamicTextOnImageOnTheDrawnPointOverGraph
    func textToImage(drawText: String, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        print(drawText)
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 10)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x:0, y:0, width:inImage.size.width, height:inImage.size.height))
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x:atPoint.x, y:atPoint.y, width:inImage.size.width, height:inImage.size.height)
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
    func updateMarkedPointText(_ index:Int,_ mapView:LineChartView) {
        self.pointsArray?.filter({$0.x == 12.0}).forEach { $0.icon = self.textToImage(drawText: String(index), inImage: #imageLiteral(resourceName: "blackDot"), atPoint: CGPoint(x: 7, y: 6)) }
        dataSet?.values = self.pointsArray!
        let data = LineChartData(dataSet: dataSet)
        
        mapView.data = data
    }
}
