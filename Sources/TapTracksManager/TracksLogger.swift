//
//  TracksLogger.swift
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

protocol TracksLogger {
    func log(tapTracks: [TapTrack])
}

final class TracksLoggerAdapter: TracksLogger {
    func log(tapTracks: [TapTrack]) {
        for tapTrack in tapTracks {
            print(tapTrack.timestamp,tapTrack.coordinates)
        }
    }
}
