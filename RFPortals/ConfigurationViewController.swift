//
//  SecondViewController.swift
//  RFPortals
//
//  Created by goliatone on 12/8/18.
//  Copyright © 2018 goliatone. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var beaconUUIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        renderView()
    }
    
    func renderView() {
        urlTextField.text = Configuration.serviceEndpoint
        userIdTextField.text = Configuration.userId
        beaconUUIDTextField.text = Configuration.beaconUUID
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        print("here")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is QRScannerViewController {
            let btn = sender as! UIButton
            let scanner = segue.destination as! QRScannerViewController
            scanner.activeSearch = QRSearch(tag: btn.tag, result:"")
            scanner.delegate = self
            
            print("Opening view controller: \(btn.tag)")
        } else {
            print("else here", segue.destination)
        }
    }
}

extension ConfigurationViewController: QRScannerDelegate {
    func onCodeDetected(search: QRSearch) {
        print("we have code", search)
        
        switch search.tag {
        case 1:
            Configuration.serviceEndpoint = search.result
        case 2:
            Configuration.userId = search.result
        case 3:
            Configuration.beaconUUID = search.result
        default:
            print("we dont know")
        }
        
        renderView()
    }
}
