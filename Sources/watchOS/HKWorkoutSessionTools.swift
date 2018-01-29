//
//  HKWorkoutSessionTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 1/15/18.
//  Copyright © 2018 Vladas Zakrevskis. All rights reserved.
//

import HealthKit

public extension HKWorkoutSession {
    
    class func create(_ conf: (HKWorkoutConfiguration) -> ()) -> HKWorkoutSession? {
        let workoutConfiguration = HKWorkoutConfiguration()
        conf(workoutConfiguration)
        return try? HKWorkoutSession(configuration: workoutConfiguration)
    }
}
