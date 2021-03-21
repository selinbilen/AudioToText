//
//  ViewController.swift
//  SpeechToText
//
//  Created by selin eylül bilen on 3/20/21.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var TextView: UITextView!
    
    var audio: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.isHidden = true
        activitySpinner.stopAnimating()
    }
    
    func speech() {
        SFSpeechRecognizer.requestAuthorization { stats in
            if stats == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audio = sound
                        self.audio.delegate = self
                        sound.play()
                    }catch{
                        print("Error!!")
                    }
                    let recognizer = SFSpeechRecognizer()
                    let req = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: req){ (result, error) in
                        if let error = error{
                            print("Error: \(error)")
                        }else{
                            self.TextView.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    @IBAction func RecordBut(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        speech()
    }
}

