//
//  tracksStorage.swift
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation

protocol TracksStorer {
    func save(tapTrack: TapTrack, completion: @escaping () -> Void)
    func load(completion: @escaping ([TapTrack]) -> Void)
}


//For this particular case I will storage on memory because we need only 10 tracks. However, if we need to track a huge amount of data, we can modify this class in order to use a better kind of persistence
final class TracksStorerAdapter {
    let threadSafeQueue = DispatchQueue(label: "storer-queue", qos: .userInteractive)

    private enum Constants {
        static let maxTracksAllowed = 10
    }

    private var tapTracks = [TapTrack]()
}

//MARK: - Track Storer

extension TracksStorerAdapter: TracksStorer {
    func save(tapTrack: TapTrack, completion: @escaping () -> Void) {
        threadSafeQueue.async { [weak self] in
            guard let self = self else {
                if Thread.isMainThread {
                    completion()
                } else {
                    DispatchQueue.main.async { completion() }
                }
                return
            }
            self.tapTracks.append(tapTrack)

            if self.tapTracks.count > Constants.maxTracksAllowed {
                self.tapTracks.removeFirst()
            }

            if Thread.isMainThread {
                completion()
            } else {
                DispatchQueue.main.async { completion() }
            }
        }
    }

    func load(completion: @escaping ([TapTrack]) -> Void) {
        threadSafeQueue.async { [weak self] in
            if Thread.isMainThread {
                completion(self?.tapTracks ?? [])
            } else {
                DispatchQueue.main.async { completion(self?.tapTracks ?? []) }
            }
        }
    }
}

