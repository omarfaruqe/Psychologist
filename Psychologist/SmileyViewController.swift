//
//  SmileyViewController.swift
//  Smiley
//
//  Created by Omar Faruqe on 2015-06-04.
//  Copyright (c) 2015 Omar Faruqe. All rights reserved.
//

import UIKit

class SmileyViewController: UIViewController, FaceViewDataSource {

    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }       
        
    }
    
    
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource=self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 90 {  // 0 is very sad and 100 is estatic
        didSet{
            happiness = min(max(happiness, 0),  100)
            println("happiness=\(happiness)")
            updateUI()
        }
        
    }
    func updateUI(){
        faceView.setNeedsDisplay()
        
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }

}
