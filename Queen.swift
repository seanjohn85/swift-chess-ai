//
//  Queen.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

/*
 
 This class is used to make Bishop elements in a chess game
 
 
 */

//inherts from the UIChesspiece custom class
class Queen: UIChessPiece{
    //constructor to make chess pieces
    init(frame : CGRect, color: UIColor, VC: ViewController){
        super.init(frame : frame)
        //sets the Queen to match colour
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♛"
        }else{
            self.text = "♕"
        }
        //ensure Queen sits on top of the tiles
        self.isOpaque = false
        //set the text color
        self.textColor = color
        //allows the user to interact with the piece (allows drap and drop)
        self.isUserInteractionEnabled = true
        //set position and size of Queen
        self.textAlignment = .center
        self.font = self.font.withSize(36)
        //add to the screen
        VC.chessPieces.append(self)
        VC.view.addSubview(self)
    }
    
    //required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func moveOk(source: BoardIndex, dest : BoardIndex) -> Bool{
        
        if source.row == dest.row || source.col == dest.col{
            return true
        }
        
        if abs(dest.row - source.row) == abs(dest.col - source.col){
            return true
        }
        
        return false
        
    }
    
}
