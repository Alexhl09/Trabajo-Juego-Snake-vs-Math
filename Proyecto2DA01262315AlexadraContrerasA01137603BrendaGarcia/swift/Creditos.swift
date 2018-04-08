//
//  Creditos.swift
//  Proyecto2DA01262315AlexadraContrerasA01137603BrendaGarcia
//
//  Created by Alejandro on 06/04/18.
//  Copyright © 2018 AleyBrenda. All rights reserved.
//

import Foundation
import SpriteKit
class Creditos: SKScene {
    private var sign: SKSpriteNode?;
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            sign?.zPosition = 4;
            
            if nodes(at: location)[0].name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                scene?.scaleMode = SKSceneScaleMode.aspectFill;
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
            }
        }
    }
}
