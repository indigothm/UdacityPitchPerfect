//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ilia Tikhomirov on 20/08/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import AVFoundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init (title: String, filePath: NSURL) {
        self.filePathUrl = filePath
        self.title = title
    }
    
   static func recordingWillStop () {
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}