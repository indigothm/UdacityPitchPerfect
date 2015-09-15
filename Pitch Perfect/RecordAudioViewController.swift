//
//  RecordAudioViewController.swift
//  Pitch Perfect
//
//  Created by Ilia Tikhomirov on 16/08/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopButton.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = "tap to record"
        super.viewWillAppear(true)
        stopButton.hidden = true
    }

    @IBOutlet weak var recordingLabel: UILabel!

    
    @IBAction func recordAudio(sender: UIButton) {

        println("record button pressed")
        stopButton.hidden = false
        recordingLabel.text = "recording"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if flag {
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePath: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else{
            println("error")
            recordingButton.enabled = true
            recordingLabel.enabled = true
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC: PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data
            
        }
        
    }

    
    
    @IBAction func stopButtonDidTouch(sender: UIButton) {
        audioRecorder.stop()
        RecordedAudio.recordingWillStop()

    }
}

