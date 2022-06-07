//
//  ViewController.swift
//  FrutasDoBrasil
//
//  Created by Marcus Vinicius Silva de Sousa on 07/06/22.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController,ARSessionDelegate{
    
    @IBOutlet var arView: ARView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            configuration.trackingImages = imagesToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        arView.session.run(configuration)
        arView.session.delegate = self
    }
    
    func session (_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
        for anchor in anchors {
            
            guard let imageAnchor = anchor as? ARImageAnchor else {return}
            
            if let imageName = imageAnchor.name, imageName == "CupuacuCard" {
                let entity = AnchorEntity(anchor: imageAnchor)
                
                if let scene = try? Experience.loadBox() {
                    if let cup = scene.findEntity(named: "Cupuacu"){
                        entity.addChild(cup)
                        arView.scene.addAnchor(entity)
                        
                    }
                }
            }
            
        }
    }
}
