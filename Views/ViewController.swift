//
//  ViewController.swift
//  ScrewShop
//
//  Created by Lloyd Maze Powell III on 5/31/18.
//  Copyright © 2018 L.M.PowellEnterprise. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    var animation = [String: CAAnimation]()
    var falling:Bool = true
    var screwed:Bool = true
    @IBOutlet var sceneView: ARSCNView!
    var player = AVAudioPlayer()
    var audioPlayer = AVAudioPlayer()
    var gif = SKVideoNode()
    var objectNode: SCNNode!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        // Set the scene to the view
        sceneView.scene = scene
        loadAnimations()
        //music
        //playSong(for: "UGKScrew10", type: "mp3")
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    //MARK: music
    func playSong(for resource: String, type: String) {
        // Prevent a crash in the event that the resource or type is invalid
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else { return }
        // Convert path to URL for audio player
        let sound = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: sound)
            player.prepareToPlay()
            player.play()
        } catch {
            // Create an assertion crash in the event that the app fails to play the sound
            assert(false, error.localizedDescription)
        }
    }
    
    func loadAnimations(){
        //load character in animation
        // let astroman = SCNScene(named: "art.scnassets/Falling/FallingFixed.dae")!
        let screwSkull = SCNScene(named: "art.scnassets/goldscrew1.dae")!
        let screwSkull2 = SCNScene(named: "art.scnassets/goldscrew1.dae")!
//        let slab = SCNScene(named: "art.scnassets/thenewestslab.dae")!
        //parent of all the nodes
        // let node = SCNNode()
        let newNode = SCNNode()
        let newNode2 = SCNNode()
//        let newNode3 = SCNNode()
        //add children to the parent
//        for child in astroman.rootNode.childNodes{
//            node.addChildNode(child)
//        }
        for child in screwSkull.rootNode.childNodes{
            newNode.addChildNode(child)
        }
        for child in screwSkull2.rootNode.childNodes{
            newNode2.addChildNode(child)
        }
//        for child in slab.rootNode.childNodes{
//            newNode3.addChildNode(child)
//        }
        // Set up some properties
//        node.position = SCNVector3(0, -1, 1)
//        node.scale = SCNVector3(0.2, 0.2, 0.2)
        newNode.position = SCNVector3(0, 0, -10)
        newNode.scale = SCNVector3(0.2, 0.2, 0.2)
        newNode.rotation = SCNVector4(30, 0, 0, 0)
        newNode2.position = SCNVector3(-70, 0, -10)
        newNode2.scale = SCNVector3(0.2, 0.2, 0.2)
        newNode.rotation = SCNVector4(-30, 0, 0, 0)
//        newNode3.position = SCNVector3(-70, 0, -10)
//        newNode3.scale = SCNVector3(0.2, 0.2, 0.2)
        // Add the node to the scene
        //sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(newNode)
        sceneView.scene.rootNode.addChildNode(newNode2)
//        sceneView.scene.rootNode.addChildNode(newNode3)
        // Load all the DAE animations
//        loadAnimation(withKey:"space", sceneName: "art.scnassets/Falling/FallingFixed", animationIdentifier: "FallingFixed-1")
//        if(falling){
//            playAnimation(key: "space")
//        }
        loadAnimation(withKey:"bad_skull_screw_group1", sceneName: "art.scnassets/goldscrew1", animationIdentifier: "goldscrew1-1")
        if(screwed){
            playAnimation(key: "bad_skull_screw_group1")
        }
//        loadAnimation(withKey:"slabbz", sceneName: "art.scnassets/thenewestslab", animationIdentifier: "slabbz_scale_X")
//        if(screwed){
//            playAnimation(key: "slabbz")
//        }
    }
    
    func loadAnimation(withKey: String, sceneName:String, animationIdentifier:String){
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
     //   let newSceneURL = Bundle.main.url(forResource: sceneName, withExtension: "scn")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            animation[withKey] = animationObject
        }
    }
    
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        sceneView.scene.rootNode.addAnimation(animation[key]!, forKey: key)
    }
    
    func playEffect(file: String, ext: String){
        do {
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: ext)!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch {
            // Create an assertion crash in the event that the app fails to play the sound
            assert(false, error.localizedDescription)
        }
    }
    
}
