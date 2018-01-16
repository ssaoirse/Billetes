//
//  QRCodeScannerViewController.swift
//  Billetes
//
//  Created by Saoirse on 1/16/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class QRCodeScannerViewController: UIViewController {
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton = true
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.scanInModalAction()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error",
                                          message: "This app is not authorized to use Back Camera.",
                                          preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting",
                                              style: .default,
                handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel",
                                              style: .cancel,
                                              handler: nil))
            default:
                alert = UIAlertController(title: "Error",
                                          message: "Reader not supported by the current device",
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .cancel,
                                              handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    func scanInModalAction() {
        guard checkScanPermissions() else { return }
        
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        
        present(readerVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - QRCodeReader Delegate Methods

extension QRCodeScannerViewController: QRCodeReaderViewControllerDelegate{
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }

    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

