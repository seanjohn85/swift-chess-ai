//
//  Dummy.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

//class to set dummy piece pos

class Dummy: Piece{
    // store the x and y positions
    private var xStore: CGFloat!
    private var yStore: CGFloat!
    //see the piece protocol
    var x : CGFloat{
        get{
            return self.xStore
        }
        set{
            self.xStore = newValue
        }
    }
    var y : CGFloat {
        get{
            return self.yStore
        }
        set{
            self.yStore = newValue
        }
    }
    
    //constructor for class objects
    init(frame: CGRect){
        self.xStore = frame.origin.x
        self.yStore = frame.origin.y
    }
    
    init(){
        
    }
}
