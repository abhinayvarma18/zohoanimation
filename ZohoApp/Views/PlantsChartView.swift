//
//  PlantsChartView.swift
//  ZohoApp
//
//  Created by ABHINAY on 03/04/18.
//  Copyright © 2018 ABHINAY. All rights reserved.
//

import UIKit
import Charts

class PlantsChartView: UIView {
    //MARK:Constraint for making UI dynamic
    @IBOutlet weak var plantsLabel:UILabel!
    @IBOutlet weak var mapView:LineChartView!
    @IBOutlet weak var horizontalScrollView:UIScrollView!
    @IBOutlet weak var horizontalContentView: UIView!
    @IBOutlet var horizontalImageViews: [UIView]!
    @IBOutlet weak var weeklayWorkloadLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var monthLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func showPlantChartViewsLabel() {
        UIView.animate(withDuration: animationTimeForViews, animations: {()
            self.dateLabel.alpha = 1.0
            self.monthLabel.alpha = 1.0
            self.weeklayWorkloadLabel.alpha = 1.0
        })
    }
    
    func hidePlantChartViewsLabel() {
        UIView.animate(withDuration: animationTimeForViews, animations: {()
            self.dateLabel.alpha = 0.0
            self.monthLabel.alpha = 0.0
            self.weeklayWorkloadLabel.alpha = 0.0
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        horizontalScrollView.isScrollEnabled = true
        horizontalScrollView.showsHorizontalScrollIndicator = true
    }

}
