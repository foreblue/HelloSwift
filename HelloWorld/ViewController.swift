//
//  ViewController.swift
//  HelloWorld
//
//  Created by dy.sim on 2014. 10. 21..
//  Copyright (c) 2014년 dy.sim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    var progressTimer: NSTimer?
    
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var volumeStepper: UIStepper!
    @IBOutlet var volumeLabel: UILabel!
    
    
    override func viewDidLoad() {
        var bundleURL: NSURL = NSBundle.mainBundle().URLForResource("demo", withExtension: "mp3")!
        self.audioPlayer = AVAudioPlayer(contentsOfURL: bundleURL, error: nil)
        self.audioPlayer!.delegate = self
        self.progressSlider!.value = 0
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPlayButton(button: UIButton) {
        self.audioPlayer!.play()
        makeProgressTimer()
    }

    @IBAction func clickStopButton(button: UIButton) {
        self.audioPlayer!.stop()
        invalidateProgressTimer()
    }

    @IBAction func clickVolumeStepper(stepper: UIStepper) {
        self.audioPlayer!.volume = CFloat(stepper.value)
        self.volumeLabel!.text = NSString(format: "%.1f", stepper.value)
    }
    
    func makeProgressTimer() {
        self.progressTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("checkCurrentTime"), userInfo: nil, repeats: true)
    }
    
    func invalidateProgressTimer() {
        self.progressTimer!.invalidate()
    }
    
    func checkCurrentTime() {
        self.progressSlider.value = CFloat(self.audioPlayer!.currentTime / self.audioPlayer!.duration)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        invalidateProgressTimer()
    }
}
