//
//  WateringBubbleView.swift
//  ZohoApp
//
//  Created by ABHINAY on 03/04/18.
//  Copyright © 2018 ABHINAY. All rights reserved.
//

import UIKit

class WateringBubbleView: UIView {
  @IBOutlet weak var nextWateringInLabel:UILabel!
  @IBOutlet weak var numberOfDaysLabel:UILabel!
  @IBOutlet weak var wateringInEverySevenDayLabel:UILabel!
  @IBOutlet weak var wateringInfoLabel:UILabel!
  @IBOutlet weak var waterinInfoDescriptionLabel:UILabel!
  @IBOutlet weak var plantsInfoLabel:UILabel!
  @IBOutlet weak var temperatureLabel:UILabel!
  @IBOutlet weak var humidityLabel:UILabel!
  @IBOutlet weak var lightLabel:UILabel!
  @IBOutlet weak var temperatureDescriptionLabel:UILabel!
  @IBOutlet weak var humidityDescriptionLabel:UILabel!
  @IBOutlet weak var lightDescriptionLabel:UILabel!
  @IBOutlet weak var stackView:UIStackView!
  @IBOutlet weak var bubbleView: UIView!
  var bubbleLayer: CAShapeLayer! = CAShapeLayer()
  var smallBubbleLayer:CAShapeLayer! = CAShapeLayer()
  var tickLayer:CAShapeLayer! = CAShapeLayer()
  var tickAnimationLayer:CAShapeLayer! = CAShapeLayer()
  var combinedPath: UIBezierPath!
  lazy var tickPath : UIBezierPath = {
        let tickBeizerPath = UIBezierPath()
        tickBeizerPath.move(to: CGPoint(x: 20.0, y: 30.0))
        tickBeizerPath.addLine(to: CGPoint(x: 30.0, y: 40.0))
        tickBeizerPath.addLine(to: CGPoint(x: 45.0, y: 25.0))
        return tickBeizerPath
    }()
 
    lazy var tickAnimationPath : UIBezierPath = {
        let tickBeizerPath = UIBezierPath()
        tickBeizerPath.move(to: CGPoint(x: 35.0, y: 20.0))
//        tickBeizerPath.addQuadCurve(to:CGPoint(x:30.0,y:15.0), controlPoint: CGPoint(x:45.0,y:25.0))
        tickBeizerPath.addCurve(to: CGPoint(x:20.0,y:30.0), controlPoint1: CGPoint(x:30.0,y:15.0), controlPoint2: CGPoint(x:2.0,y:2.0))
        //tickBeizerPath.addCurve(to: , controlPoint1: , controlPoint2: CGPoint(x:5.0,y:5.0))
        return tickBeizerPath
    }()
    
    var bigBubbleBeizerPath:UIBezierPath!
    var smallBubbleBeizerPath:UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addLayerToView()
        
        self.bubbleView.layer.borderWidth = 5.0
        self.bubbleView.layer.borderColor = Colors.greenBlueColor.cgColor
      //  numberOfDaysLabel.translatesAutoresizingMaskIntoConstraints = false
       // numberOfDaysLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    func addLayerToView() {
        bubbleLayer.strokeColor = UIColor.white.cgColor
        bubbleLayer.lineWidth = 3.0
        bubbleLayer.fillColor = Colors.greenBlueColor.cgColor
        
        smallBubbleLayer.strokeColor = UIColor.white.cgColor
        smallBubbleLayer.lineWidth = 3.0
        
        bigBubbleBeizerPath = self.drawBubbleShape(centerX:30.0, yMax: 55.0, topY: 15.0, andRadius: 15.0)
        smallBubbleBeizerPath =  self.drawBubbleShape(centerX: 42, yMax: 40.0, topY: 10.0, andRadius: 5)
        
        combinedPath = UIBezierPath()
        combinedPath.append(bigBubbleBeizerPath)
        
        combinedPath.append(smallBubbleBeizerPath)
        //combinedPath.usesEvenOddFillRule = true
    
        tickLayer.path = tickPath.cgPath
        tickLayer.strokeColor = UIColor.clear.cgColor
        tickLayer.lineWidth = 3.0
        
        tickAnimationLayer.path = tickAnimationPath.cgPath
        tickAnimationLayer.strokeColor = UIColor.clear.cgColor
        tickAnimationLayer.lineWidth = 3.0
        
        
        Colors.greenBlueColor.setFill()
        bubbleLayer.fillColor = Colors.greenBlueColor.cgColor
        bubbleLayer.path = bigBubbleBeizerPath.cgPath
        smallBubbleLayer.path = smallBubbleBeizerPath.cgPath
        smallBubbleLayer.fillColor = Colors.greenBlueColor.cgColor
        bubbleView.layer.addSublayer(smallBubbleLayer)
        bubbleView.layer.addSublayer(bubbleLayer)
        
        tickLayer.fillColor = UIColor.clear.cgColor
        tickAnimationLayer.fillColor = UIColor.clear.cgColor
    
        bubbleView.layer.addSublayer(tickAnimationLayer)
        bubbleView.layer.addSublayer(tickLayer)
    }
    
    func drawBubbleShape(centerX:CGFloat,yMax:CGFloat, topY:CGFloat, andRadius:CGFloat) -> UIBezierPath {
        let bubblePath = UIBezierPath()
        let nearToTopCornerPointLeftX = centerX - andRadius
        let nearToTopCornerPointRightX = centerX + andRadius
        let nearToTopCornerPointY:CGFloat = topY + andRadius
        bubblePath.move(to:CGPoint(x: centerX, y:topY))
        
        bubblePath.addCurve(to: CGPoint(x:centerX,y:yMax), controlPoint1: CGPoint(x: nearToTopCornerPointRightX, y: nearToTopCornerPointY), controlPoint2: CGPoint(x: centerX + 20.0, y: yMax - 2.0))
        
        bubblePath.addCurve(to: CGPoint(x:centerX,y:topY), controlPoint1: CGPoint(x: centerX - 20, y: yMax - 2.0), controlPoint2: CGPoint(x: nearToTopCornerPointLeftX, y: nearToTopCornerPointY))
        return bubblePath
    }
    
    override func awakeFromNib() {
        
    }
    
    func showWaterBubbleViewsLabel() {
        self.wateringInfoLabel.alpha = 1.0
        self.waterinInfoDescriptionLabel.alpha = 1.0
        self.plantsInfoLabel.alpha = 1.0
        self.temperatureLabel.alpha = 1.0
        self.humidityLabel.alpha = 1.0
        self.lightLabel.alpha = 1.0
        self.temperatureDescriptionLabel.alpha = 1.0
        self.humidityDescriptionLabel.alpha = 1.0
        self.lightDescriptionLabel.alpha = 1.0
    }
    
    func hideWaterBubbleViewsLabel() {
        UIView.animate(withDuration: animationTimeForViews, animations: {()
            self.wateringInfoLabel.alpha = 0.0
            self.waterinInfoDescriptionLabel.alpha = 0.0
            self.plantsInfoLabel.alpha = 0.0
            self.temperatureLabel.alpha = 0.0
            self.humidityLabel.alpha = 0.0
            self.lightLabel.alpha = 0.0
            self.temperatureDescriptionLabel.alpha = 0.0
            self.humidityDescriptionLabel.alpha = 0.0
            self.lightDescriptionLabel.alpha = 0.0
        })
    }
    
    
    func animatePatternAndDays() {
        for index in 1..<8 {
            self.numberOfDaysLabel.pushTransition(1.0)
            if(index == 1) {
                self.numberOfDaysLabel.text = "1 Day"
            }else{
                self.numberOfDaysLabel.text = "\(index) Days"
            }
        }
    }
    
    func animateAndUpdateLabelDaysValue(_ flag:Bool, _ andTextCount:Int, _ completionHandler: @escaping ()-> () ) {
        UIView.transition(with: self.numberOfDaysLabel, duration: 0.6, options: .transitionCrossDissolve, animations: {()
            if(andTextCount == 1) {
                self.numberOfDaysLabel.text = "1 day"
            } else {
                self.numberOfDaysLabel.text = "\(andTextCount) days"
            }
            self.numberOfDaysLabel.sizeToFit()
        }, completion: {(_) in
            if flag {
                if andTextCount != 7 {
                    self.animateAndUpdateLabelDaysValue(flag, andTextCount + 1, completionHandler)
                }else {
                    completionHandler()
                }
            } else {
                if andTextCount != 1 {
                    self.animateAndUpdateLabelDaysValue(flag, andTextCount - 1, completionHandler)
                }else {
                    completionHandler()
                }
            }
        })
    }
    
    func animateBubbleView(_ tickEnabled:Bool) {
        
//        var flag:Bool = true
       // bubbleLayer.strokeColor = Colors.greenBlueColor.cgColor
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 0.0
        startAnimation.duration = 1.0
        
        CATransaction.begin()
        if(tickEnabled) {
            CATransaction.setCompletionBlock({
                     CATransaction.begin()
                    CATransaction.setCompletionBlock({
                         self.tickAnimationLayer.strokeColor = UIColor.white.cgColor
                    })
                    print("step3 is been executed")
                    self.bubbleView.backgroundColor = .white
                    self.bubbleLayer.fillColor = UIColor.white.cgColor
                    self.smallBubbleLayer.fillColor = UIColor.white.cgColor
                    
                    self.tickLayer.strokeColor = Colors.greenBlueColor.cgColor
                    self.tickAnimationLayer.strokeColor = Colors.greenBlueColor.cgColor
                    
                    //externalAbc
                    //
                    
                    let startAnimationTick = CABasicAnimation(keyPath: "strokeStart")
                    startAnimationTick.fromValue = 0.0
                    startAnimationTick.toValue = 1.0
                    startAnimationTick.duration = 1.0
                    startAnimationTick.fillMode = kCAFillModeBackwards
                    startAnimationTick.isRemovedOnCompletion = true
                    self.tickAnimationLayer.add(startAnimationTick, forKey: "anim1")
                    
                    let startAnimationTickLayer = CABasicAnimation(keyPath: "strokeStart")
                    startAnimationTickLayer.fromValue = 1.0
                    startAnimationTickLayer.toValue = 0.0
                    startAnimationTickLayer.duration = 2.0
                    startAnimationTickLayer.fillMode = kCAFillModeForwards
                    // startAnimationTick.isRemovedOnCompletion = false
                    self.tickLayer.add(startAnimationTickLayer, forKey: "anim2")
                    CATransaction.commit()
            })
            print("step1 is been executed")
            //bubbleLayer.strokeColor = Colors.greenBlueColor.cgColor
            let startAnim = CABasicAnimation(keyPath: "strokeStart")
            startAnim.fromValue = 0.0
            startAnim.toValue = 0.8
            let endAnim = CABasicAnimation(keyPath: "strokeEnd")
            endAnim.fromValue = 1.0
            endAnim.toValue = 0.2
            
            let animat = CAAnimationGroup()
            animat.fillMode = kCAFillModeBackwards
            animat.animations = [startAnim, endAnim]
            animat.duration = 1.0
            bubbleLayer.add(animat, forKey: "anim")
            smallBubbleLayer.add(animat, forKey: "anim")
            
        }else {
            let linearAnimation = CABasicAnimation(keyPath: "strokeStart")
            linearAnimation.fromValue = 0.8
            linearAnimation.toValue = 0.0
            let endAnim = CABasicAnimation(keyPath: "strokeEnd")
            endAnim.fromValue = 1.0
            endAnim.toValue = 0.2
            
            let animat = CAAnimationGroup()
            animat.fillMode = kCAFillModeBackwards
            animat.animations = [linearAnimation, endAnim]
            animat.duration = 2.0
            smallBubbleLayer.add(animat, forKey: "myanim")
            
            let tickAnimation = CABasicAnimation(keyPath: "strokeStart")
            tickAnimation.duration = 3.0
            tickAnimation.fromValue = 0.0
            tickAnimation.toValue = 1.0
            bubbleLayer.add(tickAnimation, forKey: "anim5")
            CATransaction.setCompletionBlock({
               
                print("step3 is been executed")
                self.bubbleView.backgroundColor = Colors.greenBlueColor
                self.bubbleLayer.fillColor = Colors.greenBlueColor.cgColor
                self.smallBubbleLayer.fillColor = Colors.greenBlueColor.cgColor
            
                self.tickLayer.strokeColor = UIColor.clear.cgColor
                self.tickAnimationLayer.strokeColor = UIColor.clear.cgColor
            })
        }
        CATransaction.commit()
    }
    
    
    func externalAbc(_ tickEnabled:Bool, flag:Bool) {
        if tickEnabled && flag {
            print("step3 is been executed")
            self.bubbleView.backgroundColor = .white
            self.bubbleLayer.fillColor = UIColor.white.cgColor
            self.smallBubbleLayer.fillColor = UIColor.white.cgColor
            self.tickLayer.strokeColor = Colors.greenBlueColor.cgColor
            self.tickAnimationLayer.strokeColor = Colors.greenBlueColor.cgColor
            
            let startAnimationTick = CABasicAnimation(keyPath: "strokeStart")
            startAnimationTick.fromValue = 0.0
            startAnimationTick.toValue = 1.0
            startAnimationTick.duration = 1.0
            startAnimationTick.fillMode = kCAFillModeRemoved
            //startAnimationTick.isRemovedOnCompletion = true
            self.tickAnimationLayer.add(startAnimationTick, forKey: "anim1")
            
            let startAnimationTickLayer = CABasicAnimation(keyPath: "strokeStart")
            startAnimationTickLayer.fromValue = 0.0
            startAnimationTickLayer.toValue = 1.0
            startAnimationTickLayer.duration = 1.0
            startAnimationTickLayer.fillMode = kCAFillModeForwards
            // startAnimationTick.isRemovedOnCompletion = false
            self.tickLayer.add(startAnimationTickLayer, forKey: "anim2")
            self.externalAbc(tickEnabled, flag: false)
        }else {
            print("step4 is been executed \(tickEnabled)")
            self.tickAnimationLayer.strokeColor = UIColor.white.cgColor
        }
    }
}

extension UIView {
    func pushTransition(_ duration:CFTimeInterval) {
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionLinear)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionFade)
    }
}

