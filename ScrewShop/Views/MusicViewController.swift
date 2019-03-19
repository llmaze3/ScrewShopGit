//
//  MusicViewController.swift
//  ScrewShop
//
//  Created by Lloyd Maze Powell III on 2/1/19.
//  Copyright © 2019 L.M.PowellEnterprise. All rights reserved.
//

import UIKit
import AVFoundation

//AVAudioPlayer instance
var audioPlayer: AVAudioPlayer!
var thisSong = 0
var songs:[String] = []
class MusicViewController: UIViewController {

    
    @IBOutlet var otherGifView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        otherGifView.loadGif(name: "updatedscrewtitlescreen")
        // Do any additional setup after loading the view.
        getSongNames()
    } 
    //Get the song names from within the bundle and save them into an array. The name of the song is the last item
    //In the string and the extension needs to be replaced(deleted)
    func getSongNames(){
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song in songPath{
                var mySong = song.absoluteString
                //store it as a string
                if mySong.contains(".mp3"){
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    print(mySong)
                    songs.append(mySong)
                }
            }
        }
        catch{
            print("not found")
        }
    }
    
    func playThis(thisOne:String){
        do {
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: thisOne, ofType: ".mp3")!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            //thisSong += 1
            audioPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do{
                try audioSession.setCategory(.playback, mode: .default, options: [])
            }
            catch{
                
            }
            audioPlayer.play()
        }
        catch {
            // Create an assertion crash in the event that the app fails to play the sound
            assert(false, error.localizedDescription)
        }
    }

    @IBAction func startPlaylist(_ sender: Any) {
        playThis(thisOne: songs[thisSong])
    }
    @IBAction func lastButton(_ sender: Any) {
        if thisSong > 0{
            playThis(thisOne: songs[thisSong-1])
            thisSong -= 1
        }
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if thisSong < songs.count-1{
            playThis(thisOne: songs[thisSong+1])
            thisSong += 1
        }
        else{
            
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if audioPlayer.isPlaying == false{
            audioPlayer.play()
        }
    }
    
}
