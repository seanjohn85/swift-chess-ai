//
//  Pawn.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit


/*
 
 This class is used to make pawn elements in a chess game
 
 
 */

//inherts from the UIChesspiece custom class
class Pawn: UIChessPiece{
    var triesToAdvanceBy2 = false
    //constructor to make chess pieces
    init(frame : CGRect, color: UIColor, VC: ViewController){
        super.init(frame : frame)
        //sets the pawn to match colour
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♟"
        }else{
            self.text = "♙"
        }
        //ensure pawn sits on top of the tiles
        self.isOpaque = false
        //set the text color
        self.textColor = color
        //allows the user to interact with the piece (allows drap and drop)
        self.isUserInteractionEnabled = true
        //set position and size of pawn
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
    
    
    func moveOk(source: BoardIndex, dest : BoardIndex) ->Bool{
        //check triesToAdvanceBy2
        if source.col == dest.col{
            if (source.row == 1 && dest.row == 3 && color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) || (source.row == 6 && dest.row == 4 && color != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ){
                triesToAdvanceBy2 = true
                return true
           
            }
        }
        triesToAdvanceBy2 = false
        
        //check advance by one
        var moveFrward = 0
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            moveFrward = 1
        }else{
            moveFrward = -1
        }
        
        
        if dest.row == source.row + moveFrward{
            if (dest.col == source.col - 1) || (dest.col == source.col) || (dest.col == source.col + 1){
                return true
            }
            
        }
        return false
        
    }
   
}
