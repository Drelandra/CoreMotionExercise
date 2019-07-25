//
//  ViewController.swift
//  CoreMotionExercise
//
//  Created by Andre Elandra on 11/07/19.
//  Copyright © 2019 Andre Elandra. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()
    let pedoManager = CMPedometer()
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var accelerometerLabel: UILabel!
    
    @IBOutlet weak var stepCounterLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAccelerometer()
        // Do any additional setup after loading the view.
    }

    func startAccelerometer() {
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 0.1
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let dataAccel = data{
                print(dataAccel)
                self.accelerometerLabel.text = String(format: "%.2f", dataAccel.acceleration.x)
                
                if (dataAccel.acceleration.x > 0.1){
                    self.colorView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: CGFloat(dataAccel.acceleration.x))
                }else if (dataAccel.acceleration.x < 0.1){
                    self.colorView.backgroundColor = UIColor.black
                    }
            }
            
        }
        
    }

    }
    
    func checkPedometer() {
        
        if CMPedometer.isStepCountingAvailable(){
            let calender = Calendar.current
            pedoManager.queryPedometerData(from: calender.startOfDay(for: Date()), to: Date()) { (data, error) in
                print(data!)
            }
            
        }
        
    }
    
    func startPedometer() {
        
        pedoManager.startUpdates(from: Date()) { (data, error) in
            DispatchQueue.main.async {
                if let dataStep = data{
                self.stepCounterLabel.text = String.init(format: "%.2f", dataStep.numberOfSteps, "Steps")
                }
            }
        }
        
    }
    
    func stopPedometer() {
        
        pedoManager.stopUpdates()
        
    }
    
    
    @IBAction func startPedometerButton(_ sender: UIButton) {
        startPedometer()
    }
    
    @IBAction func stopPedometerButton(_ sender: UIButton) {
        stopPedometer()
    }
}
