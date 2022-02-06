//
//  MockTracksLogger.swift
//  
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
@testable import TapTracksManager

final class MockTracksLogger: TracksLogger {
    var logInvokedCount = 0
    var lastTapTracksLogged = [TapTrack]()

    func log(tapTracks: [TapTrack]) {
        lastTapTracksLogged = tapTracks
        logInvokedCount += 1
    }
    

}
