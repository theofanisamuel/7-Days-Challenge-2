//
//  ChallengeInfoViewController.swift
//  7 Days Challenge
//
//  Created by Calvin Leonardo on 05/04/20.
//  Copyright © 2020 Mini Challenge 1 - G19. All rights reserved.
//

import UIKit
import MobileCoreServices

class ChallengeInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var challengeNameLbl: UILabel!
    @IBOutlet weak var minRepsLbl: UILabel!
    @IBOutlet weak var objectLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnDoChallenge(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            controller.sourceType = .camera
            controller.mediaTypes = [kUTTypeMovie as String]
            controller.delegate = self
                
            present(controller, animated: true, completion: nil)
        }
        else {
            print("Camera is not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
            let selectorToCall = #selector(videoSaved(_:didFinishSavingWithError:context:))
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
            let videoData = try? Data(contentsOf: selectedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent(videoFileName)
            try! videoData?.write(to: dataPath, options: [])
        }
      
        picker.dismiss(animated: true)
    }
    
    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if let theError = error {
            print("error saving the video = \(theError)")
        } else {
           DispatchQueue.main.async(execute: { () -> Void in
           })
        }
    }
}