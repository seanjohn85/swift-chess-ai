//
//  BoardIndex.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

//xcode swift protocol
struct BoardIndex: Equatable {
    
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        
        self.row = row
        self.col = col
    }
    
    
    static func == (left: BoardIndex, right: BoardIndex) -> Bool{
        return left.row == right.row && left.col == right.col
        
    }
}
