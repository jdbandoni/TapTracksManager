//
//  TracksManager.swift
//
//  Created by Jonathan Daniel Bandoni on 05/02/2022.
//

import Foundation
import UIKit
import CoreGraphics

//This is public because it probably should live in a module
public final class TapTracksManager: NSObject {
    private let logger: TracksLogger
    private let storer: TracksStorer
    private let notificationCenter = NotificationCenter.default

    public static let shared = TapTracksManager()

    init(logger: TracksLogger = TracksLoggerAdapter(), storer: TracksStorer = TracksStorerAdapter()) {
        self.logger = logger
        self.storer = storer
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    public func startTracking(view: UIView? = UIApplication.shared.delegate?.window ?? nil) {
        guard let view = view else { return }

        let gestureRecognizer = UIGestureRecognizer()
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)

        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}

//MARK: - UIGestureRecognizerDelegate

extension TapTracksManager: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let tapTrack = TapTrack(timestamp: Date().timeIntervalSince1970, coordinates: touch.location(in: touch.view))
        storer.save(tapTrack: tapTrack, completion: {})
        return false
    }

}

//MARK: - App Life-cycle Observers

private extension TapTracksManager {
    @objc func appMovedToBackground() {
        storer.load { [weak self] tapTracks in
            self?.logger.log(tapTracks: tapTracks)
        }
    }
}

