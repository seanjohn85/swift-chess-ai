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
        
        
        //loop trough all rows
        for row in 0..<col{
            
            //loop trough all cols
            for c in 0..<col{
                //case 0 & 1 black pieces, case 6,7 white peices
                switch row{
                case 0:
                    switch c{
                    case 0:
                        board [row][c] = Rook(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 1:
                        board [row][c] = Knight(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 2:
                        board [row][c] = Bishop(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 3:
                        board [row][c] = Queen(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 4:
                        blackKing = King(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                        board [row][c] = blackKing
                    case 5:
                        board [row][c] = Bishop(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 6:
                        board [row][c] = Knight(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    default:
                        board [row][c] = Rook(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                        
                    }
                case 1:
                    switch c{
                    case 0:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 1:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 2:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 3:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 4:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 5:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    case 6:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    default:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), VC: vc)
                    }
                    
                case 6:
                    switch c{
                    case 0:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 1:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 2:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 3:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 4:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 5:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 6:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    default:
                        board [row][c] = Pawn(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    }
                    
                
                case 7:
                    switch c{
                    case 0:
                        board [row][c] = Rook(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 1:
                        board [row][c] = Knight(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 2:
                        board [row][c] = Bishop(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 3:
                        board [row][c] = Queen(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 4:
                        whiteKing = King(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                        board [row][c] = whiteKing
                    case 5:
                        board [row][c] = Bishop(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    case 6:
                        board [row][c] = Knight(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    default:
                        board [row][c] = Rook(frame: ChessBoard.getFrame(forRow: row, forCol: c), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), VC: vc)
                    }
                    
                    
                default :
                    board [row][c] = Dummy(frame: ChessBoard.getFrame(forRow: row, forCol: c))
                    
                }
                
            }
            
        }

    }
    
    
    static func getFrame(forRow row: Int, forCol col: Int) -> CGRect{
        //get the postion of the piece
        let x = CGFloat(ViewController.spaceFromLeftEdge + col * ViewController.tileSize)
        let y = CGFloat(ViewController.spaceFromTopEdge + row * ViewController.tileSize)
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: ViewController.tileSize, height: ViewController.tileSize))
        
    }
}
