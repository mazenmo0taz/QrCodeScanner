//
//  ScannerVC.swift
//  BarCodeScanner
//
//  Created by Mazen Moataz on 16/10/2025.
//
import UIKit
import AVFoundation

enum CameraError{
    case invalidCameraDevice 
    case failedToCreateDeviceInput,failedToAddInputToSession
    case failedToAddOutputToSession
    case failedToReadCode
    case failedToSetupPreviewLayer
}

protocol ScannerVCDelegate: AnyObject {
    func didScan(code: String)
    func didFindError(error: CameraError)
}

final class ScannerVC: UIViewController{
    let captureSession = AVCaptureSession()
    var previewLayer:AVCaptureVideoPreviewLayer?
    weak var scannerDelegate:ScannerVCDelegate?
    
    init(scannerDelegate:ScannerVCDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
        scannerDelegate?.didFindError(error: .failedToSetupPreviewLayer)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    func setupCaptureSession(){
        let input:AVCaptureDeviceInput
        let output = AVCaptureMetadataOutput()
        guard let device = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didFindError(error: .invalidCameraDevice)
            return
        }
        do {
             try input = AVCaptureDeviceInput(device: device)
        } catch {
            scannerDelegate?.didFindError(error: .failedToCreateDeviceInput)
            return
        }
        
        if captureSession.canAddInput(input){
            captureSession.addInput(input)
        }else{
            scannerDelegate?.didFindError(error: .failedToAddInputToSession)
        }
        
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = [.qr,.ean8,.ean13,.code128,.code39,.codabar,.code93,.pdf417,.code39Mod43]
        }else{
            scannerDelegate?.didFindError(error: .failedToAddOutputToSession)
        }
       
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metaDataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            //scannerDelegate?.didFindError(error: .failedToReadCode)
            return
        }
        
        guard let foundCode = metaDataObject.stringValue else {
            scannerDelegate?.didFindError(error: .failedToReadCode)
            return
        }
        scannerDelegate?.didScan(code: foundCode)
    }
}
