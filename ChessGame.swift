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
    //possible moves for ai returned
    func getArrayOfPossibleMoves(forPice piece: UIChessPiece) -> [BoardIndex]{
        var arrayOfMoves : [BoardIndex] = []
        let source = chessBoard.getIndex(piece: piece)!
        
        for row in 0..<chessBoard.col{
            for c in 0..<chessBoard.col{
                
                let dest = BoardIndex(row: row, col: c)
                
                if isNormalMoveValid(piece: piece, sourceIndex: source, destIndex: dest){
                    arrayOfMoves.append(dest)
                }
            }
            
        }
        
        return arrayOfMoves
        
    }
    
    
    func makeAIMove(){
        //get the white king if possible
        
        if getPlayerChecked() == "White"{
            for apice in chessBoard.vc.chessPieces{
                if apice.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    guard let source = chessBoard.getIndex(piece: apice) else{
                        continue
                    }
                    
                    guard let dest = chessBoard.getIndex(piece: chessBoard.whiteKing) else{
                        continue
                    }
                    
                    if isNormalMoveValid(piece: apice, sourceIndex: source, destIndex: dest){
                        move(piece: apice, sourceIndex: source, destIndex: dest, toOrigin: chessBoard.whiteKing.frame.origin)
                        return
                    }
                }
            }
        }
        
        
        //other moves
        
        //attack undefened white pices, if there is no check on the black king
        if getPlayerChecked() == nil{
            if didAttackUndefendedPiece(){
                return
            }
        }
        
        
        //
        
        var moveFound = false
        var numOfTrysToExcapeCheck = 0
        
        searchForMoves: while moveFound == false{
            
            //get random piece
            
            let ranPieceArrayIndex = Int(arc4random_uniform(UInt32(chessBoard.vc.chessPieces.count)))
            
            let pieceToMove = chessBoard.vc.chessPieces[ranPieceArrayIndex]
            
            guard pieceToMove.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) else{
                continue searchForMoves
            }
            
            //get random move
            let movesArray = getArrayOfPossibleMoves(forPice: pieceToMove)
            guard movesArray.isEmpty == false else {
                continue searchForMoves
            }
            
            let randMovesArrayIndex = Int(arc4random_uniform(UInt32(movesArray.count)))
            
            let ranDestIndex = movesArray[randMovesArrayIndex]
            
            let destOrigin = ChessBoard.getFrame(forRow: ranDestIndex.row, forCol: ranDestIndex.col).origin
            
            guard let sourceIndex = chessBoard.getIndex(piece: pieceToMove) else{
                continue searchForMoves
            }
            
            //simulate move on board matrix

            let pieceTaken = chessBoard.board[ranDestIndex.row][ranDestIndex.col]
            
            chessBoard.board[ranDestIndex.row][ranDestIndex.col] = chessBoard.board[sourceIndex.row][sourceIndex.col]
            
            chessBoard.board[sourceIndex.row][sourceIndex.col] = Dummy()
            
            if numOfTrysToExcapeCheck < 1000{
                guard getPlayerChecked() != "Black" else{
                    //undo the move
                    chessBoard.board[sourceIndex.row][sourceIndex.col] = chessBoard.board[ranDestIndex.row][ranDestIndex.col]
                    chessBoard.board[ranDestIndex.row][ranDestIndex.col] = pieceTaken
                    
                    numOfTrysToExcapeCheck += 1
                    
                    continue searchForMoves
                }
            }
            
            //undo the move
            chessBoard.board[sourceIndex.row][sourceIndex.col] = chessBoard.board[ranDestIndex.row][ranDestIndex.col]
            chessBoard.board[ranDestIndex.row][ranDestIndex.col] = pieceTaken
            
            //best move available
            if didBestMoveForAI(forScoreOver: 2){
                return
            }
            
            move(piece: pieceToMove, sourceIndex: sourceIndex, destIndex: ranDestIndex, toOrigin: destOrigin)
            
            moveFound = true
        }
    }
    
    func didBestMoveForAI(forScoreOver limit: Int) -> Bool{
        return false
    }
    
    func didAttackUndefendedPiece() -> Bool{
        
        return false
    }
    func getPawnToBePromoted() -> Pawn?{
        for chessPiece in chessBoard.vc.chessPieces{
            if let pawn = chessPiece as? Pawn{
                let pawnIndex = ChessBoard.indexOf(origin: pawn.frame.origin)
                if pawnIndex.row == 0 || pawnIndex.row == 7{
                    return pawn
                }
            }
        }
        return nil
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
    
    
    //check mate
    func getPlayerChecked() -> String?{
        guard let whiteKingIndex = chessBoard.getIndex(piece: chessBoard.whiteKing) else{
            return nil
        }
        guard let blackKingIndex = chessBoard.getIndex(piece: chessBoard.blackKing) else{
            return nil
        }
        
        for row in 0..<chessBoard.col{
            for col in 0..<chessBoard.col{
                if let chessPiece = chessBoard.board[row][col] as? UIChessPiece{
                    let chessPieceIndex = BoardIndex(row: row, col: col)
                    if chessPiece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                        if isNormalMoveValid(piece: chessPiece, sourceIndex: chessPieceIndex, destIndex: whiteKingIndex){
                            return "White"
                            
                        }
                    }else{
                        if isNormalMoveValid(piece: chessPiece, sourceIndex: chessPieceIndex, destIndex: blackKingIndex){
                            return "Black"
                            
                        }
                    }
                }
            }
        }
        return nil
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
