//
//  VideoPlayer.swift
//  VideoPlayerCustom
//
//  Created by SoKoL on 03.02.2022.
//

import UIKit
import AVFoundation

class VideoPlayer: UIView {
    
    let videoPlayer = PlayerView()
    private var player = AVPlayer()
    var url: URL?
    
    init(url: URL) {
        self.url = url
        super.init(frame: .zero)
        
        inicialize()
    }
    
    init () {
        self.url = URL(string: "")
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(videoPlayer)
        videoPlayer.frame = bounds
    }
    
    func inicialize() {
        player = AVPlayer(url: url!)
        videoPlayer.player = player
        player.volume = 1.0
        player.play()
    }
}
