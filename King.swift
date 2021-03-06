//
//  King.swift
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
class King: UIChessPiece{
    //constructor to make chess pieces
    init(frame : CGRect, color: UIColor, VC: ViewController){
        super.init(frame : frame)
        //sets the King to match colour
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♚"
        }else{
            self.text = "♔"
        }
        //ensure King sits on top of the tiles
        self.isOpaque = false
        //set the text color
        self.textColor = color
        //allows the user to interact with the piece (allows drap and drop)
        self.isUserInteractionEnabled = true
        //set position and size of King
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
        let diffenceInRows = abs(dest.row - source.row)
        let diffenceInCols = abs(dest.col - source.col)
        
        if case 0...1 = diffenceInRows{
            if case 0...1 = diffenceInCols{
                return true
            }
            
        }
        
        return false
        
    }
    
}
