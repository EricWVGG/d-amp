//
//  MotionManager.swift
//  MotionManager
//
//  Created by Eric Jacobsen on 9/20/21.
//

import CoreMotion
import Combine
import UIKit


class MotionManager: ObservableObject {
    @Published var roll: Double = 0.0
    private var motionManager: CMMotionManager
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 1/60
        self.motionManager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if UIAccessibility.isReduceMotionEnabled {
                return
            }
            // all clear
            if let motionData = motionData {
                self.roll = motionData.attitude.roll
            }
        }
        
    }
}


extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

public func clamp<T>(_ value: T, minValue: T, maxValue: T) -> T where T : Comparable {
    return min(max(value, minValue), maxValue)
}

