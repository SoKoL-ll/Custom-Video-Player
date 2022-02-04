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
//        var player = UserDefaults.standard.get(key: url!.absoluteString)
//        if player == nil {
        player = AVPlayer(url: url!)
//            UserDefaults.standard.commit(object: player!, key: url!.absoluteString)
//        }
        videoPlayer.player = player
        player.volume = 1.0
        player.play()
    }
}

//extension UserDefaults {
//    func commit(object: AVPlayer, key: String) {
//        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
//        self.set(encodedData, forKey: key)
//        self.synchronize()
//    }
//
//    func get(key: String) -> AVPlayer? {
//        if let decoded = self.data(forKey: key) {
//            return try! NSKeyedUnarchiver.unarchivedObject(ofClass: AVPlayer.self, from: decoded)
//        }
//        return nil
//    }
//}
