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
    
    
    
    func getIndex(piece: UIChessPiece) -> BoardIndex?{
        for row in 0..<col{
            for cols in 0..<col{
                let chessPiece = board[row][cols] as? UIChessPiece
                if piece == chessPiece{
                    return BoardIndex(row: row, col: cols)
                    
                }
            }
        }
        return nil
    }
    
    //constructor
    init(viewController : ViewController) {
        //set the view
        vc = viewController
        
        //initialize the board matrix with dummies
        let oneRow = Array(repeating: Dummy(), count: col)
        board = Array(repeating: oneRow, count: col)
        
        
        //loop trough all rows and set up statring chess board
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
    
    
    
    func remove(piece: Piece){
        //check if the piece is a chess piece
        if let chessPiece = piece as? UIChessPiece{
            
            //remove from the board
            let indexOfBoard = ChessBoard.indexOf(origin: chessPiece.frame.origin)
            board[indexOfBoard.row][indexOfBoard.col] = Dummy(frame: chessPiece.frame)
            
            //remove from array of chess pieces
            if let indexInArray  = vc.chessPieces.index(of: chessPiece){
                vc.chessPieces.remove(at: indexInArray)
            }
            
            //remove from screen
            chessPiece.removeFromSuperview()
            
        }
        
    }
    
    
    func place(chessPiece : UIChessPiece, destIndex : BoardIndex, toOrigin: CGPoint){
        chessPiece.frame.origin = toOrigin
        board[destIndex.row][destIndex.col] = chessPiece
        
    }
    
    
    
    //static funcs
    
    static func indexOf(origin: CGPoint) -> BoardIndex{
        
        let row = (Int(origin.y) - ViewController.spaceFromTopEdge) / ViewController.tileSize
        let col = (Int(origin.x) - ViewController.spaceFromLeftEdge) / ViewController.tileSize
        
        return BoardIndex(row: row, col: col)
    }
    
    static func getFrame(forRow row: Int, forCol col: Int) -> CGRect{
        //get the postion of the piece
        let x = CGFloat(ViewController.spaceFromLeftEdge + col * ViewController.tileSize)
        let y = CGFloat(ViewController.spaceFromTopEdge + row * ViewController.tileSize)
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: ViewController.tileSize, height: ViewController.tileSize))
        
    }
}
