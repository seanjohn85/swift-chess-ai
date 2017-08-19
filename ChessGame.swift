//
//  ChessGame.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class ChessGame: NSObject{
    var chessBoard: ChessBoard!
    
    init(viewController: ViewController){
        chessBoard = ChessBoard.init(viewController: viewController)
    }
    
    func move(piece chessPieceToMove: UIChessPiece, sourceIndex: BoardIndex, destIndex: BoardIndex, toOrigin destOrigin: CGPoint){
        
        //4 steps algrothim
        
        //get inital chess piece frame
        let initalPieceFrame  = chessPieceToMove.frame
        
        //remove piece at destination
        let pieceToRemove = chessBoard.board[destIndex.row][destIndex.col]
        
        chessBoard.remove(piece: pieceToRemove)
        
        //move chess piece to new desination
        chessBoard.place(chessPiece : chessPieceToMove, destIndex: sourceIndex, toOrigin: destOrigin)
        
        //put a dummy piece in the blank tile
        chessBoard.board[destIndex.row][destIndex.col] = Dummy(frame: initalPieceFrame)
        
    }
    
    //check if player can move
    func isMoveValid(piece: UIChessPiece, sourceIndex: BoardIndex, destIndex: BoardIndex) -> Bool{
        
        guard isMoveOnBoard(sourceIndex: sourceIndex, destIndex : destIndex) else {
            print("invalid move")
            return false
        }
        return true
    }
    
    //reject invalid movement
    func isMoveOnBoard(sourceIndex: BoardIndex, destIndex : BoardIndex) -> Bool{
        if case 0..<chessBoard.col = sourceIndex.row{
            if case 0..<chessBoard.col = sourceIndex.col{
                if case 0..<chessBoard.col = destIndex.row{
                    if case 0..<chessBoard.col = destIndex.col{
                        return true
                    }
                }
            }
            
        }
        return false
        
        
        
    }
}
