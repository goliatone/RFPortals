//
//  FirstViewController.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import UIKit
import CoreNFC

class PortalsViewController: UITableViewController {

    fileprivate var usingSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    private var isScanning: Bool = false
    private var nfcSession: NFCNDEFReaderSession!
    private var nfcMessages:[[NFCNDEFMessage]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc fileprivate func willEnterForeground() {
        print("view did appear from foreground...")
        startScanning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear...")
        startScanning()
    }
    
    func startScanning() {
        print("start scanning...")
        guard usingSimulator == false else { return showSimulatorAlertViewController()}
        if isScanning == true {
            return
        }
        
        isScanning = true
        
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.begin()
    }

    
    @IBAction func showScannerAction(_ sender: UIBarButtonItem) {
        
        let activity = NSUserActivity(activityType: Configuration.scanningActivity)
        activity.title = "Scan Portals"
        //see: https://developer.apple.com/documentation/foundation/nsuseractivity/1411706-userinfo
        activity.userInfo = ["type" : "userActivity"]
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(stringLiteral: Configuration.scanningActivity)
        view.userActivity = activity
        activity.becomeCurrent()
        
        startScanning()
    }
}

// MARK: - NFCReaderSessionDelegate
extension PortalsViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        isScanning = false
        print("Did fail to read NFC: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                
                let request = OpenPortalRequest(userId: Configuration.userId,
                                                portalAlias: record.stringValue,
                                                timestamp: NSDate().timestamp)
                HTTPService.shared.requestAccessToPortalById(openRequest: request) { (error) in
                    if let error = error {
                        print("Error", error.localizedDescription)
                    }
                }
                
                print("""
                    TypeNameFormat - \(record.typeNameFormat)
                    Identifier - \(record.identifier)
                    Type - \(record.type)
                    Payload - \(record.payload)
                    """)
            }
        }
        
        nfcMessages.append(messages)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension PortalsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return nfcMessages.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nfcMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell ?? UITableViewCell()
        
        let tagMessage = nfcMessages[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = tagMessage.records.map({ (record) -> String in
            return """
            \(record.stringValue)
            """
        }).reduce("", { (records, nextRecord) -> String in
            return records.isEmpty ? "\(nextRecord)" : records + "\n\(nextRecord)"
        })
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PortalsViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Portal Identifiers"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Handling running in sumulator
extension PortalsViewController {
    fileprivate func showSimulatorAlertViewController() {
        let alert = UIAlertController(title:"Warning", message:"App is running in a simulator. CoreNFC is not supported. Run in a real device", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
