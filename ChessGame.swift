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
    
    var winner: String?
    
    var isWhiteTurn = true
    
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
        
        
        guard usTurnColor(sameAsPiece : piece) else{
            return false
        }
        
        return isNormalMoveValid(piece: piece, sourceIndex: sourceIndex, destIndex: destIndex)
    }
    
    
    func isNormalMoveValid(piece: UIChessPiece, sourceIndex: BoardIndex, destIndex: BoardIndex) -> Bool{
        guard sourceIndex != destIndex else {
            return false
        }
        guard !(attacking(piece: piece, destIndex: destIndex)) else {
            return false
        }
        //detect pice and call piece function
        switch piece {
        case is Pawn:
            return isMoveValid(forPawn: piece as! Pawn, sourceIndex: sourceIndex, destIndex: destIndex)
        case is Rook, is Bishop, is Queen:
            return isMoveValid(forRookQueenBishop : piece, sourceIndex: sourceIndex, destIndex: destIndex)
        case is Knight:
            if !(piece as! Knight).moveOk(source: sourceIndex, dest: destIndex)
            {
                return false
            }
            
        case is King:
            return isMoveValid(forKing : piece as! King, sourceIndex: sourceIndex, destIndex: destIndex)
        default:
            break
        }
        
        return true
    }
    
    //
    func isMoveValid(forPawn piece: Pawn, sourceIndex: BoardIndex, destIndex: BoardIndex) -> Bool{
        if !piece.moveOk(source: sourceIndex, dest: destIndex){
            return false
        }
        //no attack
        if sourceIndex.col == destIndex.col{
            //advance by 2
            if piece.triesToAdvanceBy2{
                var moverForward = 0
                
                if piece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    moverForward = 1
                }else{
                    moverForward = -1
                }
                
                if chessBoard.board[destIndex.row][destIndex.col] is Dummy && chessBoard.board[destIndex.row - moverForward][destIndex.col] is Dummy{
                    return true
                }
            }
            //advance by 1
            else{
                if chessBoard.board[destIndex.row][destIndex.col] is Dummy {
                    return true
                }
            }
        }//attack
        else{
            if !(chessBoard.board[destIndex.row][destIndex.col] is Dummy) {
                return true
            }
        }
        return false
    }
    
    func isMoveValid(forRookQueenBishop piece: UIChessPiece, sourceIndex: BoardIndex, destIndex: BoardIndex) -> Bool{
        
        
        switch piece{
        case is Rook:
            if !(piece as! Rook).moveOk(source: sourceIndex, dest: destIndex){
                return false
            }
            
        case is Bishop:
            if !(piece as! Bishop).moveOk(source: sourceIndex, dest: destIndex){
                return false
            }
        default:
            if !(piece as! Queen).moveOk(source: sourceIndex, dest: destIndex){
                return false
            }
        }
        
        
        var increaseRow = 0
        //queen or bishop
        
        //rook or queen
        
      
        var increaseCol = 0
        
        if destIndex.row - sourceIndex.row != 0{
            increaseRow = (destIndex.row - sourceIndex.row) / abs(destIndex.row - sourceIndex.row)
        }
        
        if destIndex.col - sourceIndex.col != 0{
            increaseCol = (destIndex.col - sourceIndex.col) / abs(destIndex.col - sourceIndex.col)
        }
        
        
        var nextRow = sourceIndex.row + increaseRow
        var nextCol = sourceIndex.col + increaseCol
        
        while nextRow != destIndex.row || nextCol != destIndex.col{
            if !(chessBoard.board[nextRow][nextCol] is Dummy){
                return false
            }
            nextRow += increaseRow
            nextCol += increaseCol
        }
        
        
        return true
    }
    
    func isMoveValid(forKing piece: King, sourceIndex: BoardIndex, destIndex: BoardIndex) -> Bool{
        if !(piece.moveOk(source: sourceIndex, dest: destIndex)){
            return false
        }
        if oppKing(nearKing : piece, destIndex : destIndex){
            return false
        }
        return true
    }
    
    //checks if the kings are to close
    func oppKing(nearKing moving: King, destIndex: BoardIndex)-> Bool{
      
        var oppKing : King
        
        if moving == chessBoard.whiteKing{
            oppKing = chessBoard.blackKing
            
        }else{
            oppKing = chessBoard.whiteKing
        }
        
        
        var oppKingIndex : BoardIndex!
        for row in 0..<chessBoard.col {
            for col in 0..<chessBoard.col{
                if let aKing = chessBoard.board[row][col] as? King, aKing == oppKing{
                    oppKingIndex = BoardIndex(row: row, col: col)
                }
            }
        }
        
        //compute absolute diffence betwen kings
        let differenceInRows = abs(oppKingIndex.row - destIndex.row)
        let differenceInCols = abs(oppKingIndex.col - destIndex.col)
        
        //if to close move is invalid
        if case 0...1 = differenceInRows{
            if case 0...1 = differenceInCols{
                return true
            }
        }
        
        
        return false
    }
    
    //if attacked allied piece
    func attacking(piece: UIChessPiece, destIndex: BoardIndex) -> Bool{
        let destinationPiece : Piece = chessBoard.board[destIndex.row][destIndex.col]
        guard !(destinationPiece is Dummy) else {
            return false
        }
        
        let destinationChessPiece = destinationPiece as! UIChessPiece
        
        return piece.color == destinationChessPiece.color
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
    
    //rotate turn
    func changeTurn(){
        //oposite of current value
        isWhiteTurn = !isWhiteTurn
    }
    
    //check is the moved piece is the valid players
    func usTurnColor(sameAsPiece piece: UIChessPiece) -> Bool{
        if piece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            if !isWhiteTurn{
                return true
            }
        }else{
            if isWhiteTurn{
                return true
            }
        }
        return false
    }
    
    
    //game over
    
    
    func isGameOver() -> Bool{
        if didSomebodyWin(){
            return true
        }
        return false
    }
    
    func didSomebodyWin() -> Bool{
        if !(chessBoard.vc.chessPieces.contains(chessBoard.whiteKing)){
            winner = "Black"
            return true
        }
        
        if !(chessBoard.vc.chessPieces.contains(chessBoard.blackKing)){
            winner = "White"
            return true
        }
        
        return false
    }
}
