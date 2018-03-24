//
//  ScanVC.swift
//  MyF
//
//  Created by macOS on 3/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var viewScan: UIView?
    
    var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
    var device = AVCaptureDevice.default(for: AVMediaType.video)
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureSession = AVCaptureSession()
    var code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.avCaptureInputPortFormatDescriptionDidChangeNotification(notification:)), name:NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil)
        self.setupCamera()
    }
    
    private func setupCamera() {
        
        let input = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        
        if self.captureSession.canAddInput(input!) {
            self.captureSession.addInput(input!)
        }
        
        captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let videoPreviewLayer = self.previewLayer {
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = self.view.bounds
            view.layer.addSublayer(videoPreviewLayer)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8]
        } else {
            print("Could not add metadata output")
        }
        
    }
    
    var layerFrameBound =  CALayer()
    var uiLayer = CALayer()
    @objc func avCaptureInputPortFormatDescriptionDidChangeNotification(notification: NSNotification) {
        layerFrameBound.frame = CGRect(x: (self.view.bounds.width - 200) / 2, y: (self.view.bounds.height - 90) / 2, width: 200, height: 90)
        layerFrameBound.borderWidth = 3
        layerFrameBound.borderColor = UIColor.green.cgColor
        self.previewLayer?.insertSublayer(layerFrameBound, at: 1)
        if let rectOfInterest = previewLayer?.metadataOutputRectConverted(fromLayerRect: layerFrameBound.frame) {
            output.rectOfInterest = rectOfInterest
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // This is the delegate'smethod that is called when a code is readed
        for metadata in metadataObjects {
            guard let readableObject = metadata as? AVMetadataMachineReadableCodeObject else {
                continue
            }
            
            if let machineCodeObject = self.previewLayer?.transformedMetadataObject(for: readableObject) {
                self.callRectOfInterestHandlerWithRect(rect: machineCodeObject.bounds)
            }
            
            let code = readableObject.stringValue
            self.captureSession.stopRunning()
            print(code)
            let alert = UIAlertView.init(title: "Barcode", message: code, delegate: self, cancelButtonTitle: "ok")
            
            alert.show()
        }
    }
    
    func callRectOfInterestHandlerWithRect(rect: CGRect) {
        uiLayer.frame = rect
        
        uiLayer.borderColor = UIColor.red.cgColor
        uiLayer.borderWidth = 3
        
        self.view.layer.insertSublayer(uiLayer, above: self.previewLayer)
    }
    
}

extension ScannerVC: UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        uiLayer.removeFromSuperlayer()
        //self.captureSession.startRunning()
        self.dismiss(animated: true, completion: nil)
    }
    
}
