//
//  MainMenuScene.swift
//  Proyecto2DA01262315AlexadraContrerasA01137603BrendaGarcia
//
//  Created by Alejandro on 06/04/18.
//  Copyright © 2018 AleyBrenda. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if nodes(at: location)[0].name == "StartGame" {
                let scene = GamePlayScene(fileNamed: "GamePlayScene")
                scene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
            
            if nodes(at: location)[0].name == "Creditos" {
                let scene = Creditos(fileNamed: "Creditos")
                scene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
            }
            
            
            if nodes(at: location)[0].name == "Instrucciones" {
                let scene = Instrucciones(fileNamed: "Instrucciones")
                scene?.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            
            /*
             if nodes(at: location)[0].name == "Options" {
             let scene = OptionScene(fileNamed: "Options")
             scene?.scaleMode = SKSceneScaleMode.aspectFill
             self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1))
             }
             */
            
            
        }
        
    }
    
    
    
    
}
