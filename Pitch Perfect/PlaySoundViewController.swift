//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Ilia Tikhomirov on 20/08/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var avPlayer:AVAudioPlayer!
    var recievedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        avPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        avPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
    }
    
    func stopEngine() {
        
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playWithRate(rate: Float) {
        
        avPlayer.rate = rate
        avPlayer.play()
        
    }
    
    @IBAction func stopPlayButton(sender: AnyObject) {
        stopEngine()
        avPlayer.stop()
    }

    @IBAction func slowSoundPlay(sender: UIButton) {
        
        stopEngine()
        playWithRate(0.4)
        
    }
    
    @IBAction func fastSoundPlay(sender: UIButton) {
        
        self.stopEngine()
        playWithRate(2.0)
        
    }
    
    
    @IBAction func lowPitchSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch (pitch: Float) {
        
        avPlayer.stop()
        self.stopEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    @IBAction func playChimpmunkSound(sender: UIButton) {
        
       playAudioWithVariablePitch(1000)
        
    }
    
}
