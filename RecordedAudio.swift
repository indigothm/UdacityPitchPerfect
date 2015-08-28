//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ilia Tikhomirov on 20/08/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init (title: String, filePath: NSURL) {
        self.filePathUrl = filePath
        self.title = title
    }
}