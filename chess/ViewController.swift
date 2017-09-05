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
    
    var isAgainstAI : Bool!
    
    
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
                
                myGame.move(piece: piceDragged, sourceIndex: sourceIndex, destIndex: destIndex, toOrigin: destOrigin)
                //check is game over
                
                if myGame.isGameOver(){
                    displayWinner()
                    return
                }
                
                if shouldPromotePawn(){
                    promptForPwnPromotion()
                }else{
                    resumeGame()
                }
                
                
            }else{
                piceDragged.frame.origin = sourceOrgin
            }
            
        }
        
    }
    func resumeGame(){
        //display checks is any
        displayCheck()
        //change the turn
        myGame.changeTurn()
        //display turn
        updateTurnOnScreen()
        //ai move if needed
        if isAgainstAI && !myGame.isWhiteTurn{
            myGame.makeAIMove()
            
            print("AI .--------------")
            
            if myGame.isGameOver(){
                displayWinner()
                return
            }
            
            if shouldPromotePawn(){
                promote(pawn: myGame.getPawnToBePromoted()!, into: "Quenn")
            }
            
            displayCheck()
            myGame.changeTurn()
            updateTurnOnScreen()
        }
    }
    
    func promote(pawn: Pawn, into: String){
        
    }
    
    func promptForPwnPromotion(){
        
    }
    func shouldPromotePawn() -> Bool{
        return (myGame.getPawnToBePromoted() != nil)
    }
    
    func displayCheck(){
        let playerChecked = myGame.getPlayerChecked()
        
        if playerChecked != nil{
            checkedLab.text = playerChecked! + " is in check"
        }else{
            checkedLab.text = nil
        }
    }
    
    func displayWinner(){
        let alert = UIAlertController(title: "Game Over", message: "\(myGame.winner!) wins", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Main Menu", style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: "exit", sender: self)
        }))
        
        //rematch
        alert.addAction(UIAlertAction(title: "Rematch", style: UIAlertActionStyle.default, handler: { action in
            //clear screen, chess pieces and board matrix
            for piece in self.chessPieces{
                self.myGame.chessBoard.remove(piece: piece)
            }
            
            //create a new game
            self.myGame = ChessGame(viewController: self)
            
            //update labels
            self.updateTurnOnScreen()
            self.checkedLab.text =  nil
            
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
    
    
    func updateTurnOnScreen() {
        turnLab.text = myGame.isWhiteTurn ? "Whites Turn": "Black Turn"
        turnLab.textColor = myGame.isWhiteTurn ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }


}

