//
//  ViewController.swift
//  FrutasDoBrasil
//
//  Created by Marcus Vinicius Silva de Sousa on 07/06/22.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate{
    
    @IBOutlet var arView: ARView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            configuration.trackingImages = imagesToTrack
            configuration.maximumNumberOfTrackedImages = 2
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
                    if let cupuacu = scene.findEntity(named: "Cupuacu"){
                        entity.addChild(cupuacu)
                        arView.scene.addAnchor(entity)
                    }
                }
            }
            
            if let imageName = imageAnchor.name, imageName == "MaracujaCard" {
                let entity = AnchorEntity(anchor: imageAnchor)
                
                if let scene = try? Experience.loadBoxMaracuja() {
                    if let maracuja = scene.findEntity(named: "Maracuja"){
                        entity.addChild(maracuja)
                        arView.scene.addAnchor(entity)
                    }
                }
            }
            
            
            if let imageName = imageAnchor.name, imageName == "CajaCard" {
                let entity = AnchorEntity(anchor:  imageAnchor)
                
                if let scene = try? Experience.loadBoxCaja() {
                    if let caja = scene.findEntity(named: "Caja"){
                        entity.addChild(caja)
                        arView.scene.addAnchor(entity)
                    }
                }
            }
        }
    }
}
