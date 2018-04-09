//
//  AppConstants.swift
//  ZohoApp
//
//  Created by ABHINAY on 03/04/18.
//  Copyright © 2018 ABHINAY. All rights reserved.
//

import UIKit

struct Colors {
    static let greenBlueColor = UIColor(red: 63.0/255.0, green: 189.0/255.0, blue: 174.0/255.0, alpha: 0.9)
    static let blackBGColor = UIColor(red: 35.0/255.0,green: 49.0/255.0, blue: 57.0/255.0, alpha:0.96)
    static let graphLabelColor = UIColor(red: 133.0/255.0, green: 135.0/255.0, blue: 143.0/255.0, alpha: 1.0)
}

struct Fonts {
    
    static func getRegularFontWithSize(_ size:CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    static func getBoldFontWithSize(_ size:CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
}

let maxHeightConstraintOfPlantMapView:CGFloat = 755
let minHeightConstraintOfPlantMapView:CGFloat = 455

let maxBottomConstraintOfPlantMapView:CGFloat = 140
let minBottomConstraintOfPlantMapView:CGFloat = -160

let maxBottomConstraintOfWaterbubbleView:CGFloat = 0
let minBottomConstraintOfWaterbubbleView:CGFloat = -220

let maxHeightConstraintOfWaterbubbleView:CGFloat = 560
let minHeightConstraintOfWaterbubbleView:CGFloat = 360


let animationTimeForViews:Double = 1.0
let graphCurvePointsArray:[CGPoint] = [CGPoint(x:0.0,y:7.0),CGPoint(x:4.0,y:4.0),CGPoint(x:7.5,y:7.5),CGPoint(x:12.0,y:11.0),CGPoint(x:14.0,y:12.0),CGPoint(x:20.0,y:18.0),CGPoint(x:28.0,y:4.0),CGPoint(x:35.0,y:4.0)]


//////
//////
//            for index in 1..<8 {
//                if let aLabel = self.wateringBubbleView.numberOfDaysLabel {
//                    aLabel.pushTransition(1.6)
//                    if(index == 1) {
//                        aLabel.text = "1 day"
//                    }else{
//                        aLabel.text = "\(index) days"
//                    }
//
//                    aLabel.text = "\(index)"
//                }
//                self.wateringBubbleView.layoutIfNeeded()
//            }
//
//            for index in 1..<8 {
//                if let aLabel = self.wateringBubbleView.numberOfDaysLabel {
//                    aLabel.pushTransition(1.6)
//                    if(index == 1) {
//                        aLabel.text = "1 day"
//                    }else{
//                        aLabel.text = "\(index) days"
//                    }
//                }
//                self.wateringBubbleView.layoutIfNeeded()
//            }
