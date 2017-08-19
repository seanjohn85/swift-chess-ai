//
//  ViewController.swift
//  chess
//
//  Created by JOHN KENNY on 06/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    ///ui elemenets outlets
    @IBOutlet var pan: UIPanGestureRecognizer!
 

    @IBOutlet var checkedLab: UILabel!
    @IBOutlet var turnLab: UILabel!
    
    var piceDragged: UIChessPiece!
    var sourceOrgin: CGPoint!
    var destOrigin: CGPoint!
    //ui sizes
    static var spaceFromLeftEdge = 8
    static var spaceFromTopEdge = 132
    static var tileSize = 38
    
    //game and pieces
    var myGame : ChessGame!
    var chessPieces : [UIChessPiece]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instanate chess game
        chessPieces = []
        //set up the game
        myGame = ChessGame.init(viewController: self)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        piceDragged = touches.first!.view as? UIChessPiece
        print("touch \(piceDragged)")
        
        if piceDragged != nil{
            sourceOrgin = piceDragged.frame.origin
            print("so \(sourceOrgin)")
        }
    }
    //check if move is valid
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end")
        if piceDragged != nil{
            let touchLocation = touches.first!.location(in: view)
            
            //cast cgfloat to int
            var x = Int(touchLocation.x)
            var y = Int(touchLocation.y)
            
            x -= ViewController.spaceFromLeftEdge
            y -= ViewController.spaceFromTopEdge
            
            //divide by tile size
            x = (x / ViewController.tileSize) * ViewController.tileSize
            y = (y / ViewController.tileSize) * ViewController.tileSize
            
            
            x += ViewController.spaceFromLeftEdge
            y += ViewController.spaceFromTopEdge
            
            destOrigin = CGPoint(x: x, y: y)
            
            
            let sourceIndex = ChessBoard.indexOf(origin: sourceOrgin)
            let destIndex = ChessBoard.indexOf(origin: destOrigin)
            
            if myGame.isMoveValid(piece: piceDragged, sourceIndex: sourceIndex, destIndex: destIndex){
                
                piceDragged.frame.origin = destOrigin
            }else{
                piceDragged.frame.origin = sourceOrgin
            }
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        if piceDragged != nil{
            drag(piece: piceDragged!, useGestureRec: pan)
            print("test")
        }
    }
    
    
    //drag a chess piece
    func drag(piece: UIChessPiece, useGestureRec: UIPanGestureRecognizer){
        let translate = useGestureRec.translation(in: view)
        piece.center = CGPoint(x: translate.x + piece.center.x, y: translate.y + piece.center.y)
        useGestureRec.setTranslation(CGPoint.zero, in: view)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

