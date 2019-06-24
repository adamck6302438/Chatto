//
//  VideoView.swift
//  Vinder
//
//  Created by Frances ZiyiFan on 6/19/19.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

enum CallType {
    case IncomeCall
    case Default
}

class VideoView: UIView {
    
    var playerLayer: AVPlayerLayer!
    var player: AVPlayer!
    var isLoop: Bool = false
    
    let buttonContainer:UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let videoContainer:UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let leftButton:UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 0.5 * 50
        b.clipsToBounds = true
        b.backgroundColor = UIColor.yellow
        b.imageView?.contentMode = .scaleAspectFit
        b.setImage(UIImage(named: "message"), for: .normal)
        b.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        b.addTarget(self, action: #selector(sendMessageTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let rightButton:UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 0.5 * 50
        b.clipsToBounds = true
        b.backgroundColor = UIColor.red
        b.setImage(UIImage(named: "call"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        b.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        b.addTarget(self, action: #selector(callTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    //UI setup
    func setUpViews(callType : CallType){
        self.addSubview(buttonContainer)
        self.addSubview(videoContainer)
        self.buttonContainer.addSubview(rightButton)
        self.buttonContainer.addSubview(leftButton)
        
        switch callType {
        case .IncomeCall:
            self.leftButton.setImage(UIImage(named: "reject"), for: .normal)
            self.leftButton.addTarget(self, action: #selector(rejectCallTapped), for: .touchUpInside)
            self.rightButton.setImage(UIImage(named: "call"), for: .normal)
            self.leftButton.addTarget(self, action: #selector(pickUpCallTapped), for: .touchUpInside)
        case .Default:
            self.leftButton.setImage(UIImage(named: "message"), for: .normal)
            self.leftButton.addTarget(self, action: #selector(sendMessageTapped), for: .touchUpInside)
            self.rightButton.setImage(UIImage(named: "call"), for: .normal)
            self.rightButton.addTarget(self, action: #selector(callTapped), for: .touchUpInside)
        default:
            break
        }
        
        NSLayoutConstraint.activate([
            buttonContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            buttonContainer.heightAnchor.constraint(equalToConstant: 80),
            buttonContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            buttonContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            videoContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            videoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            videoContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            videoContainer.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: -5),
            
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            rightButton.widthAnchor.constraint(equalToConstant: 50),
            rightButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -50),
            rightButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 15),
            
            leftButton.heightAnchor.constraint(equalToConstant: 50),
            leftButton.widthAnchor.constraint(equalToConstant: 50),
            leftButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 50),
            leftButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 15),
            ])
        
    }

    //AVPlayer methods
    func configure(url: String) {
        let videoURL = URL(string: url)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoContainer.frame
        self.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func play() {
        if player.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player.play()
        }
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player.pause()
            player.seek(to: CMTime.zero)
            player.play()
        }
    }
    
    //handle call
    @objc func callTapped(){
        print("call")
    }
    
    @objc func sendMessageTapped(){
        print("send video message")
    }
    
    @objc func pickUpCallTapped(){
        print("pick up")
    }
    
    @objc func rejectCallTapped(){
        print("reject call")
    }
}
