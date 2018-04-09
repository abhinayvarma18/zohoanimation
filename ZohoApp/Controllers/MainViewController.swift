//
//  ViewController.swift
//  ZohoApp
//
//  Created by ABHINAY on 02/04/18.
//  Copyright © 2018 ABHINAY. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController {
    //MARK:Outlets For Main View And CustomViews
    @IBOutlet weak var plantViewBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var plantsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wateringViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wateringViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var fixedView: UIView!
    @IBOutlet weak var wateringBubbleView: WateringBubbleView!
    @IBOutlet weak var plantChartView: PlantsChartView!
    weak var timer:Timer?
    weak var newtimer:Timer?
    //MARK:LifecycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGesturesToCustomViews()
        self.plantChartView.hidePlantChartViewsLabel()
        self.wateringBubbleView.hideWaterBubbleViewsLabel()
        GraphHandler.sharedHandler.loadChartData(self.plantChartView.mapView, {()
        })
    }
    
    //MARK:Adding Gestures to both Custom Views
    func addGesturesToCustomViews() {
        let swipePlantTop = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipePlantTop.direction = UISwipeGestureRecognizerDirection.up
        plantChartView.addGestureRecognizer(swipePlantTop)
        let swipePlantBottom = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipePlantBottom.direction = UISwipeGestureRecognizerDirection.down
        plantChartView.addGestureRecognizer(swipePlantBottom)
        
        let swipeWaterTop = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureForWater))
        swipeWaterTop.direction = UISwipeGestureRecognizerDirection.up
        wateringBubbleView.addGestureRecognizer(swipeWaterTop)
        let swipeWaterBottom = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGestureForWater))
        swipeWaterBottom.direction = UISwipeGestureRecognizerDirection.down
        wateringBubbleView.addGestureRecognizer(swipeWaterBottom)
        
        
        let onClickButtonAnnimateGesture = UITapGestureRecognizer(target: self, action: #selector(self.animateWaterViewOnClick(_:)))
        wateringBubbleView.bubbleView.addGestureRecognizer(onClickButtonAnnimateGesture)
        
    }
    
    //MARK:WaterBubbleView Methods
    //MARK:On Click WaterBubbleView
    @objc func animateWaterViewOnClick(_ gesture:UITapGestureRecognizer) {
        self.animateWaterViewAfterPlantView(false)
    }
    
    //MARK:gesture recognizer on swipe WaterBubbleView
    @objc func respondToSwipeGestureForWater(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.down:
                    self.animateWaterViewAfterPlantView(false)
                case UISwipeGestureRecognizerDirection.up:
                    self.animateWaterViewAfterPlantView(true)
                default:
                    break
            }
        }
    }
    
    
    //MARK:Animation For WaterBubbleView
    //Check for base conditions
    func animateWaterViewAfterPlantView(_ flag:Bool) {
        if(flag == false) {
            self.animateWaterView(flag)
        }else if(self.plantViewBottomContraint.constant == maxBottomConstraintOfPlantMapView) {
            self.animatePlantMapView(false, true)
        }else {
            self.animateWaterView(true)
        }
    }
    
    //MARK:Main Animation On WaterView
    func animateWaterView(_ flag:Bool) {
        if flag {
            if(self.wateringViewBottomConstraint.constant == maxBottomConstraintOfWaterbubbleView) {
                return
            }
            
            self.wateringViewHeightConstraint.constant = maxHeightConstraintOfWaterbubbleView
            self.showHideWaterMapview(flag)
        }else{
            if(self.wateringViewBottomConstraint.constant == minBottomConstraintOfWaterbubbleView) {
                return
            }
            print("completion called")
            self.wateringViewHeightConstraint.constant = 400
            self.wateringViewBottomConstraint.constant = -100
            self.wateringBubbleView.hideWaterBubbleViewsLabel()
            self.showHideWaterMapview(flag)
            
            self.wateringBubbleView.animateAndUpdateLabelDaysValue(true, 1, {()
                print("1st completion called")
                self.wateringBubbleView.animateBubbleView(true)
                self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
            })
        }
        
    }
    
    //MARK: TImer callback
    @objc func update() {
        timer?.invalidate()
        print("2nd completion called")
        self.wateringBubbleView.animateAndUpdateLabelDaysValue(false, 7, {()
            self.wateringBubbleView.animateBubbleView(false)
        })
    }
    
    //MARK:Showing Hiding waterMapView
    func showHideWaterMapview(_ flag:Bool) {
        UIView.animate(withDuration: 1.0, animations: {()
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }, completion: {(_) in
            if flag {
                self.wateringViewBottomConstraint.constant = maxBottomConstraintOfWaterbubbleView
                self.wateringViewHeightConstraint.constant = minHeightConstraintOfWaterbubbleView
            }else{
                self.wateringViewBottomConstraint.constant = minBottomConstraintOfWaterbubbleView
                self.wateringViewHeightConstraint.constant = minHeightConstraintOfWaterbubbleView
            }
            
            UIView.animate(withDuration: 1.0, animations: {()
                self.view.layoutIfNeeded()
                self.view.layoutSubviews()
                if(flag) {
                    self.wateringBubbleView.showWaterBubbleViewsLabel()
                }
            }, completion: {(flagAnimation) in
                //                if flag == false {
                //                  self.wateringBubbleView.animateAndUpdateLabelDaysValue(false, 7, {()})
                //                }
            })
        })
    }
    
    
    //MARK:Plant Map Functions
    //MARK:Gesture Recognizer On plant+Animation For PlantMapView
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                self.animatePlantMapView(false,false)
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                self.animatePlantMapView(true,false)
            default:
                break
            }
        }
    }
    
    //MARK: Animation on plantmap
    func animatePlantMapView(_ flag:Bool, _ comingFromPlant:Bool) {
        if flag {
            if(self.plantViewBottomContraint.constant == maxBottomConstraintOfPlantMapView) {
                return
            }
            
            self.plantChartView.mapView.clearValues()
            self.plantsViewHeightConstraint.constant = maxHeightConstraintOfPlantMapView
            self.plantChartView.hidePlantChartViewsLabel()
        }else {
            if(self.plantViewBottomContraint.constant == minBottomConstraintOfPlantMapView) {
                return
            }
            
            self.plantsViewHeightConstraint.constant = maxHeightConstraintOfPlantMapView
            self.plantViewBottomContraint.constant = minBottomConstraintOfPlantMapView
            GraphHandler.sharedHandler.deanimatePlantView(self.plantChartView.mapView)
            self.plantChartView.hidePlantChartViewsLabel()
        }
        
        UIView.animate(withDuration: animationTimeForViews, animations: {()
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }, completion: {(_) in
            self.plantsViewHeightConstraint.constant = minHeightConstraintOfPlantMapView
            if flag {
                self.plantViewBottomContraint.constant = maxBottomConstraintOfPlantMapView
            }
            
            if(comingFromPlant) {
                //when call is coming from plant map view 
                self.animateWaterView(true)
            }
            
            UIView.animate(withDuration: animationTimeForViews, animations: {()
                self.view.layoutIfNeeded()
                self.view.layoutSubviews()
                if flag {
                    self.plantChartView.showPlantChartViewsLabel()
                }
            }, completion: {(_) in
                if flag {
              GraphHandler.sharedHandler.drawGraphWithPoints( graphCurvePointsArray, range: UInt32(100), mapView: self.plantChartView.mapView)
                    //call graphhandler
                    GraphHandler.sharedHandler.animatePlantView(self.plantChartView.mapView)
                }else {
                    self.plantChartView.mapView.clearValues()
                }
            })
        })
    }
    
    @objc func updateTime() {
        
        
    }
}
