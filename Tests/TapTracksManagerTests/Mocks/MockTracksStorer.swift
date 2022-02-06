//
//  MockTracksStorer.swift
//  
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
@testable import TapTracksManager

final class MockTracksStorer: TracksStorer {

    var saveInvokedCount = 0
    var loadInvokedCount = 0
    var lastTapTrackSaved: TapTrack?
    var tapTracksLoadStubbed: [TapTrack] = []

    func save(tapTrack: TapTrack) {
        lastTapTrackSaved = tapTrack
        saveInvokedCount += 1
    }
    
    func load() -> [TapTrack] {
        loadInvokedCount += 1
        return tapTracksLoadStubbed
    }
    
    
}
