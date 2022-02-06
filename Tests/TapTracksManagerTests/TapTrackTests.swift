//
//  TapTrackTests.swift
//  
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
import XCTest
@testable import TapTracksManager

final class TapTrackTests: XCTestCase {
    func testEquatableWhenAreEqual() {
        let firstTapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 1, y: 2))
        let secondTapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 1, y: 2))

        XCTAssertEqual(firstTapTrack, secondTapTrack)

    }

    func testEquatableWhenAreNotEqual() {
        let firstTapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 1, y: 2))
        let secondTapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 3, y: 1))
        let thirdTapTrack = TapTrack(timestamp: 1122, coordinates: CGPoint(x: 3, y: 1))

        XCTAssertNotEqual(firstTapTrack, secondTapTrack)
        XCTAssertNotEqual(secondTapTrack, thirdTapTrack)
        XCTAssertNotEqual(firstTapTrack, thirdTapTrack)
    }
}

