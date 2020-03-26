//
//  ViewController.swift
//  BroSwitch
//
//  Created by ABE Satoru on 17-11-01.
//  Copyright © 2017 polamjag. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!;
    var browsers: Array<Browser> = [];
    var defaultBrowser: String?;

    override func viewDidLoad() {
        super.viewDidLoad();

        let browserBundleIdentifiers: Array<String> = LSCopyAllHandlersForURLScheme("https" as CFString)!.takeRetainedValue() as! Array;
        browserBundleIdentifiers.forEach { bundleIdentifier in
            if let browser = Browser(bundleIdentifer: bundleIdentifier) {
                self.browsers.append(browser)
            }
        }
        self.defaultBrowser = LSCopyDefaultHandlerForURLScheme("https" as CFString)!.takeRetainedValue() as String;

        tableView.wantsLayer = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:));
    }

    override func viewDidAppear() {
        super.viewDidAppear();
        NSLog("viewDidAppear");
    }

    @objc func tableViewDoubleClick(_ sender: AnyObject) {
        if (self.browsers.count < self.tableView.selectedRow) { return; }

        let browser: Browser = self.browsers[self.tableView.selectedRow]

        NSLog(browser.bundleIdentifer);
        let setAsDefaultResult = browser.setAsDefault()
        NSLog("%d", setAsDefaultResult);
    }

    override var representedObject: Any? {
        didSet {
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BrowserInfoCell"), owner: nil) as? NSTableCellView {
            if (self.defaultBrowser == browsers[row].bundleIdentifer) {
                cell.textField?.stringValue = browsers[row].bundleIdentifer + " (default)";
            }
            else {
                cell.textField?.stringValue = browsers[row].bundleIdentifer;
            }

            cell.imageView?.image = browsers[row].icon;
            return cell
        }

        return nil
    }

    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        print(tableColumn);
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.browsers.count
    }
}

