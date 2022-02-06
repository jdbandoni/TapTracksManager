//
//  tapTrack.swift
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
import CoreGraphics

struct TapTrack {
    let timestamp: TimeInterval
    let coordinates: CGPoint
}


extension TapTrack: Equatable {
    static func ==(lhs: TapTrack, rhs: TapTrack) -> Bool {
        return lhs.timestamp == rhs.timestamp && lhs.coordinates == rhs.coordinates
    }
}
