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
        
        
        self.avPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        self.avPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
        

        
    }
    
    @IBAction func stopPlayButton(sender: AnyObject) {
        self.avPlayer.stop()
    }

    @IBAction func slowSoundPlay(sender: UIButton) {
        
        
        audioEngine.stop()
        
        audioEngine.reset()
        
        self.avPlayer.rate = 0.4
        
        self.avPlayer.play()
        
        
        
    }
    
    @IBAction func lowPitchSound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch (pitch: Float) {
        
        avPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    @IBAction func fastSoundPlay(sender: UIButton) {
        
        audioEngine.stop()
        
        audioEngine.reset()
        
        self.avPlayer.rate = 2.0
        
        self.avPlayer.play()
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
