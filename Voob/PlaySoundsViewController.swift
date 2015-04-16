//
//  PlaySoundsViewController.swift
//  Voob
//
//  Created by Olivier on 4/15/15.
//  Copyright (c) 2015 Layton. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Declare globally
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)
        
        
        // Path to the mp3 audio file, before Initialization of AVAudioPlayer
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
            
//       {
        // Instance of AVAudioPlayer, Initialization of AVAudioPlayer
        // Converting a string to NSURL = class func fileURLWithPath(path: String) -> NSURL?
        // Description:Initializes and returns a newly created NSURL object as a file URL with a specified path.
//        var filePathUrl = NSURL.fileURLWithPath(filePath)
//        }
        
//        else
            
//        {
//        println("the filePath is empty")
//        }
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

    
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0

    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
    }
       
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        }
    
    
    
    
    
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    // The function which will allow the effects to work 
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
