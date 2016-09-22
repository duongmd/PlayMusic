//
//  ViewController.swift
//  PlayMusic
//
//  Created by Student on 9/20/16.
//  Copyright © 2016 MD. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btn_play: UIButton!
    var audio = AVAudioPlayer()
    var pp = true
    
    @IBOutlet weak var sld_volume: UISlider!
    
    @IBOutlet weak var lbl_CurrentTime: UILabel!
    
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    
    @IBOutlet weak var sld_Duration: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "NhoNguoiYeu", ofType: "mp3")
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        audio.prepareToPlay()
        addThumbImageForSlide()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
   //     audio.currentTime = 250.0
        audio.delegate = self
    }
    
    func updateCurrentTime() {
        self.lbl_TimeTotal.text = String(format: "%2.2f", audio.duration/60)
        self.lbl_CurrentTime.text = String(format: "%2.2f", audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
    }
    
    func addThumbImageForSlide(){
        sld_volume.setThumbImage(UIImage(named: "thumb"), for: .normal)
        sld_volume.setThumbImage(UIImage(named: "thumbHightLight"), for: .highlighted)
        sld_Duration.setThumbImage(UIImage(named: "duration"), for: .normal)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if audio.numberOfLoops == 0 {
            btn_play.setBackgroundImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @IBAction func action_play(_ sender: AnyObject) {
       
        if (pp == false){
            btn_play.setBackgroundImage(UIImage(named: "play"), for: .normal)
            audio.pause()
            pp = true
        }
        else {
            audio.play()
            btn_play.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            pp = false
        }
        
    }
    
    
    @IBAction func sld_duration(_ sender: UISlider) {
        audio.currentTime = Double(self.sld_Duration.value * Float(audio.duration))
    }
    
    @IBAction func sld_volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    
    @IBAction func action_sw(_ sender: UISwitch) {
        if sender.isOn {
            audio.numberOfLoops = 1
        }
        else {
            audio.numberOfLoops = 0
        }
    }
    

}

