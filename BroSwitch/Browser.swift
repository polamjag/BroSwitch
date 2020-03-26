//
//  Browser.swift
//  BroSwitch
//
//  Created by ABE Satoru on 17-11-15.
//  Copyright © 2017 polamjag. All rights reserved.
//

import Foundation
import Cocoa

class Browser {
    let bundleIdentifer: String
    var bundleIdentifierAsCFString: CFString {
        return bundleIdentifer as NSString;
    }

    let pathURL: NSURL
    let icon: NSImage

    init? (bundleIdentifer: String) {
        self.bundleIdentifer = bundleIdentifer;

        let pathscf = LSCopyApplicationURLsForBundleIdentifier(bundleIdentifer as NSString, nil)

        guard let paths: Array<NSURL> = pathscf?.takeRetainedValue() as? Array<NSURL> else {
            return nil
        }

        guard let pathURL: NSURL = paths[0] as NSURL? else {
            return nil
        }

        self.pathURL = pathURL
        self.icon = NSWorkspace.shared.icon(forFile: self.pathURL.path!);
    }


    func setAsDefault() -> OSStatus {
        return LSSetDefaultHandlerForURLScheme(
            "http" as CFString,
            self.bundleIdentifierAsCFString
        );
    }
}
