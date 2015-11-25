//
//  StepController.swift
//  CoreMotionPedometer
//
//  Created by Hamilton Dang on 11/19/15.
//  Copyright © 2015 Codon. All rights reserved.
//

import Foundation
import CoreMotion

class StepController{
    let pedometer = CMPedometer()
    var dataModel: DataModel!
    
    func updateStepRT(){
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startPedometerUpdatesFromDate(NSDate()){
                (data: CMPedometerData?, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    if error == nil {
                        if let steps = data?.numberOfSteps as? Int{
                            self.dataModel.totalSteps = self.dataModel.totalSteps + steps
                        }
                    }
                })
            }
        }
        print("step count data avilable?  \(CMPedometer.isStepCountingAvailable())")
        print("core motion activity avilable? \(CMMotionActivityManager.isActivityAvailable())")
        print("dataModel step count in RT:\(dataModel.totalSteps)")
    }

    
    func historicQuery(){
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let oldDate = calendar.dateByAddingUnit(.Minute, value: -10, toDate: NSDate(), options: NSCalendarOptions.WrapComponents)
        if CMPedometer.isStepCountingAvailable(){
            pedometer.queryPedometerDataFromDate(oldDate!, toDate: NSDate(), withHandler: { (data: CMPedometerData?, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if error == nil {
                        if let steps = data?.numberOfSteps as? Int{
                            self.dataModel.totalSteps = self.dataModel.totalSteps + steps
                        }
                    }
                })
            })
        }
        print("step count data avilable?  \(CMPedometer.isStepCountingAvailable())")
        print("core motion activity avilabe? \(CMMotionActivityManager.isActivityAvailable())")
        print("dataModel step count after 10 min: \(dataModel.totalSteps)")
    }
}
