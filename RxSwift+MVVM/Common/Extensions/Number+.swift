//
//  Number+.swift
//  RxSwift+MVVM
//
//  Created by Nguyen Anh  Tuan on 21/07/2023.
//

import Foundation

extension Numeric {
    func toString() -> String {
        return String(describing: self)
    }
}

extension Double {
    /// - returns: Rounded value with specific round rule and precision
    func roundToPlaces(_ rule: FloatingPointRoundingRule = . toNearestOrEven, precision: Int) -> Double {
        let divisor = pow(10.0, Double(precision))
        return (self * divisor).rounded(rule) / divisor
    }
}
