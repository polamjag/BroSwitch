//
//  FloatingWindowView.swift
//  BroSwitch
//
//  Created by ABE Satoru on 17-11-19.
//  Copyright © 2017 polamjag. All rights reserved.
//

import Cocoa

class FloatingWindowView: NSView {

    override init (frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.masksToBounds = true
        self.layer?.cornerRadius = 10
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
