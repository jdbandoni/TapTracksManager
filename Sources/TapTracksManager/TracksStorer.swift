//
//  tracksStorage.swift
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

protocol TracksStorer {
    func save(tapTrack: TapTrack)
    func load() -> [TapTrack]
}


//For this particular case I will storage on memory because we need only 10 tracks. However, if we need to track a huge amount of data, we can modify this class in order to use a better kind of persistence
final class TracksStorerAdapter: TracksStorer {

    private enum Constants {
        static let maxTracksAllowed = 10
    }

    private var tapTracks = [TapTrack]()

    func save(tapTrack: TapTrack) {
        tapTracks.append(tapTrack)
        
        guard tapTracks.count > Constants.maxTracksAllowed else { return }
        tapTracks.removeFirst()
    }

    func load() -> [TapTrack] {
        return tapTracks
    }
}

