//
//  NSDecimalNumber+Extensions.swift
//  Nano
//
//  Created by Zack Shapiro on 12/13/17.
//  Copyright © 2017 Nano Wallet Company. All rights reserved.
//

import Foundation

extension NSDecimalNumber {

    var rawAsUsableAmount: NSDecimalNumber {
        let divider = NSDecimalNumber(mantissa: 1, exponent: 30, isNegative: false)
        return self.dividing(by: divider)
    }

    /// transform a raw value into its human-readable equivilant
    var rawAsUsableString: String? {
        let result = rawAsUsableAmount

        let numberFormatter = Currency.nano.numberFormatter
        return numberFormatter.string(from: result)
    }

    var rawAsDouble: Double? {
        guard let string = rawAsUsableString else { return nil }
        return Double(string)
    }

    var asRawValue: NSDecimalNumber {
        return self.multiplying(byPowerOf10: 30)
    }

    /// Transform a human-readable value like 10.0 into its raw equivilant
    var asRawString: String {
        return self.asRawValue.stringValue
    }

}

