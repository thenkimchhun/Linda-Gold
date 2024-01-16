//
//  CameraService.swift
//  E-Funde-iOS
//
//  Created by Puttheavy tep on 16/5/2566 BE.
//

import Foundation
import AVFoundation
import UIKit

class CameraService {
    var session:  AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    var output: AVCapturePhotoOutput?
    var previewLayer = AVCaptureVideoPreviewLayer()
    func checkPermission(completed: @escaping (Bool) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                DispatchQueue.main.async {
                    if granted {
                        completed(true)
                    }else {
                        completed(false)
                    }
                }
            })
        case .restricted:  break;
        case .denied:
            completed(false)
        case .authorized:
            completed(true)
        @unknown default: break
            
        }
    }
    
    //MARK: - Capture Photo
    func capturePhoto(delegate: AVCapturePhotoCaptureDelegate,with settings: AVCapturePhotoSettings = AVCapturePhotoSettings())  {
        //Need to correct image orientation before moving further
        self.delegate = delegate
        output?.capturePhoto(with: settings, delegate: delegate)
    }
    
    func stopRunning() {
        if let session = session, session.isRunning{
            session.stopRunning()
        }
    }
    enum CameraCase {
        case front, back
    }
    func prepareCamera(cameraCase: CameraCase) {
        let session = AVCaptureSession()
        session.sessionPreset = .hd1280x720
        output = AVCapturePhotoOutput()
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: cameraCase == .front ? .front : .back
        ).devices.first else { return }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: device)
        } catch {
            return
        }
        
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
            session.addOutput(output!)
        }
        previewLayer.videoGravity = .resizeAspect
        previewLayer.session = session
        self.session = session
        //MARK: starting capture session
        DispatchQueue.global(qos: .background).async {
            if !(self.session!.isRunning) {
                self.session!.startRunning()
            }
        }
    }
}
