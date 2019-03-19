//
//  MainViewController.swift
//  ScrewShop
//
//  Created by Lloyd Maze Powell III on 6/25/18.
//  Copyright © 2018 L.M.PowellEnterprise. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var enterAR: UIButton!
    @IBAction func playVideo(_ sender: Any) {
        guard let Video = Bundle.main.path(forResource: "introvid", ofType: "mp4") else {return}
        let VideoURL = URL(fileURLWithPath: Video)
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            playerController.player?.play()
        }
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let Video = Bundle.main.path(forResource: "introvid", ofType: "mp4") else {return}
        let VideoURL = URL(fileURLWithPath: Video)
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            playerController.player?.play()
        }
    }
    */
    @IBOutlet var gifView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.loadGif(name: "updatedscrewtitlescreen")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gifView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
