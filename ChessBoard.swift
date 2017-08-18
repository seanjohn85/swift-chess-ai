//
//  ChessBoard.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class ChessBoard: NSObject
{
    //2d matrix of pieces
    var board : [[Piece]]!
    var vc : ViewController!
    //board cols and rows qty (never changes)
    let col = 8
    var whiteKing : King!
    var blackKing : King!
    
    //constructor
    init(viewController : ViewController) {
        //set the view
        vc = viewController
        
        //initialize the board matrix with dummies
        let oneRow = Array(repeating: Dummy(), count: col)
        board = Array(repeating: oneRow, count: col)

    }
    
    
    func getFrame(forRow row: Int, forCol col: Int) -> CGRect{
        //get the postion of the piece
        let x = CGFloat(ViewController.spaceFromLeftEdge + col * ViewController.tileSize)
        let y = CGFloat(ViewController.spaceFromTopEdge + row * ViewController.tileSize)
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: ViewController.tileSize, height: ViewController.tileSize))
        
    }
}
