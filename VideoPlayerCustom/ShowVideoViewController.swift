//
//  ShowVideoViewController.swift
//  VideoPlayerCustom
//
//  Created by SoKoL on 03.02.2022.
//

import UIKit
import AVFoundation

class ShowVideoViewController: UIViewController {
    
    @IBOutlet weak var playStop: UIButton!
    var url = ""
    var videoPlayer = VideoPlayer()
    var flagForPlayPause = true
    var flagForVolume = true
    let leftTapAreaView = UIView()
    let rightTapAreaView = UIView()
    
    @IBOutlet weak var videoScreenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer = VideoPlayer(url: URL(string: url)!)
        videoScreenView.backgroundColor = .black
    
        videoScreenView.addSubview(videoPlayer)
        
        videoPlayer.frame = CGRect(x: 0, y: 0, width: videoScreenView.bounds.width, height: videoScreenView.bounds.height)
    
        inicializeTaps()
        
        videoScreenView.addSubview(leftTapAreaView)
        videoScreenView.addSubview(rightTapAreaView)
        
        leftTapAreaView.leftAnchor.constraint(equalTo: self.videoPlayer.leftAnchor).isActive = true
        leftTapAreaView.topAnchor.constraint(equalTo: self.videoPlayer.topAnchor).isActive = true
        leftTapAreaView.bottomAnchor.constraint(equalTo: self.videoPlayer.bottomAnchor).isActive = true
        leftTapAreaView.rightAnchor.constraint(equalTo: self.videoPlayer.centerXAnchor).isActive = true
        
        rightTapAreaView.rightAnchor.constraint(equalTo: self.videoPlayer.rightAnchor).isActive = true
        rightTapAreaView.topAnchor.constraint(equalTo: self.videoPlayer.topAnchor).isActive = true
        rightTapAreaView.bottomAnchor.constraint(equalTo: self.videoPlayer.bottomAnchor).isActive = true
        rightTapAreaView.leftAnchor.constraint(equalTo: self.videoPlayer.centerXAnchor).isActive = true
        
        videoPlayer.isUserInteractionEnabled = false
        rightTapAreaView.isUserInteractionEnabled = true
        leftTapAreaView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    private func inicializeTaps() {
        leftTapAreaView.backgroundColor = .clear
        leftTapAreaView.translatesAutoresizingMaskIntoConstraints = false
    
        rightTapAreaView.backgroundColor = .clear
        rightTapAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        let doubleTapForward = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped))
        let doubleTapBack = UITapGestureRecognizer(target: self, action: #selector(leftViewTapped))
        
        doubleTapBack.numberOfTapsRequired = 2
        doubleTapForward.numberOfTapsRequired = 2
        leftTapAreaView.addGestureRecognizer(doubleTapBack)
        rightTapAreaView.addGestureRecognizer(doubleTapForward)
        
        let singleTapBack = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        let singleTapForward = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        
        singleTapForward.numberOfTapsRequired = 1
        singleTapBack.numberOfTapsRequired = 1
        leftTapAreaView.addGestureRecognizer(singleTapBack)
        rightTapAreaView.addGestureRecognizer(singleTapForward)
        
        singleTapBack.require(toFail: doubleTapBack)
        singleTapForward.require(toFail: doubleTapForward)
        singleTapBack.delaysTouchesBegan = true
        doubleTapBack.delaysTouchesBegan = true
        doubleTapForward.delaysTouchesBegan = true
        singleTapForward.delaysTouchesBegan = true
    }
    
    @objc func leftViewTapped() {
        let nowTime = CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentTime())!)
        let newTime = (nowTime - 15.0 < 0.0) ? 0.0 : nowTime - 15.0
        videoPlayer.videoPlayer.player?.seek(to: CMTimeMake(value: Int64(newTime * 1000), timescale: 1000))
    }
    
    @objc func singleTapped() {
        if flagForPlayPause {
            videoPlayer.videoPlayer.player?.pause()
            playStop.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            videoPlayer.videoPlayer.player?.play()
            playStop.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        flagForPlayPause = !flagForPlayPause
    }
    
    
    @objc func rightViewTapped() {
        let duration =  CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentItem!.duration)!)
        let nowTime = CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentTime())!)
        let newTime = (nowTime + 15.0 > duration) ? duration : nowTime + 15.0
        videoPlayer.videoPlayer.player?.seek(to: CMTimeMake(value: Int64(newTime * 1000), timescale: 1000))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayer.frame = videoScreenView.bounds
    }
    
    @IBAction func playPauseButton(_ sender: UIButton) {
        if flagForPlayPause {
            videoPlayer.videoPlayer.player?.pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            videoPlayer.videoPlayer.player?.play()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        flagForPlayPause = !flagForPlayPause
    }
    
    @IBAction func volumeButton(_ sender: UIButton) {
        if flagForVolume {
            videoPlayer.videoPlayer.player?.volume = 0.0
            sender.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        } else {
            videoPlayer.videoPlayer.player?.volume = 1.0
            sender.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
        }

        flagForVolume = !flagForVolume
    }
    
    @IBAction func forwardButton(_ sender: UIButton) {
        let duration = CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentItem!.duration)!)
        let nowTime = CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentTime())!)
        let newTime = (nowTime + 15.0 > duration) ? duration : nowTime + 15.0
        videoPlayer.videoPlayer.player?.seek(to: CMTimeMake(value: Int64(newTime * 1000), timescale: 1000))
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let nowTime = CMTimeGetSeconds((videoPlayer.videoPlayer.player?.currentTime())!)
        let newTime = (nowTime - 15.0 < 0.0) ? 0.0 : nowTime - 15.0
        videoPlayer.videoPlayer.player?.seek(to: CMTimeMake(value: Int64(newTime * 1000), timescale: 1000))
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
