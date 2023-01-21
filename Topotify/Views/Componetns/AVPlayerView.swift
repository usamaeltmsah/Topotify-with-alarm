//
//  AVPlayerView.swift
//  Topotify
//
//  Created by Usama Fouad on 31/12/2022.
//

import SwiftUI
import UIKit
import AVKit

struct AVPlayerView: UIViewControllerRepresentable {

    @Binding var videoURL: URL?

    private var player: AVPlayer? {
        guard let videoURL else { return nil }
        return AVPlayer(url: videoURL)
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.modalPresentationStyle = .fullScreen
        playerController.player = player
        playerController.player?.play()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return AVPlayerViewController()
    }
}
