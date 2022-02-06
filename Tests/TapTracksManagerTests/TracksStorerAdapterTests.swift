//
//  TracksStorerAdapterTests.swift
//  
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
import XCTest
@testable import TapTracksManager

final class TracksStorerAdapterTests: XCTestCase {
    func testSaveAndLoadOne() {
        let storer = TracksStorerAdapter()
        let tapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 1, y: 2))
        storer.save(tapTrack: tapTrack)

        let tapTracksLoaded = storer.load()
        XCTAssertEqual(tapTracksLoaded.count, 1)
        XCTAssertEqual(tapTracksLoaded.first, tapTrack)
        
    }

    func testSaveAndLoadTwo() {
        let storer = TracksStorerAdapter()
        let firstTapTrack = TapTrack(timestamp: 1234, coordinates: CGPoint(x: 1, y: 2))
        let secondTapTrack = TapTrack(timestamp: 2121, coordinates: CGPoint(x: 3, y: 1))
        storer.save(tapTrack: firstTapTrack)
        storer.save(tapTrack: secondTapTrack)

        let tapTracksLoaded = storer.load()
        XCTAssertEqual(tapTracksLoaded.count, 2)
        XCTAssertEqual(tapTracksLoaded.first, firstTapTrack)
        XCTAssertEqual(tapTracksLoaded[1], secondTapTrack)
    }

    func testSaveAndLoadMoreThanTen() {
        let storer = TracksStorerAdapter()
        var tapTracks = [TapTrack]()
        for i in 0..<11 {
            let tapTrack = TapTrack(timestamp: TimeInterval(i), coordinates: CGPoint(x: i, y: i))
            tapTracks.append(tapTrack)
            storer.save(tapTrack: tapTrack)
        }

        let tapTracksLoaded = storer.load()
        XCTAssertEqual(tapTracksLoaded.count, 10)
        for i in 0..<10 {
            XCTAssertEqual(tapTracksLoaded[i], tapTracks[i+1])
        }
    }
}
