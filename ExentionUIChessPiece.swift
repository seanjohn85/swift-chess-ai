//
//  ExentionUIChexxPiece.swift
//  chess
//
//  Created by JOHN KENNY on 07/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

typealias UIChessPiece = UILabel

extension UIChessPiece : Piece{
    
    var x : CGFloat {get{
    return self.frame.origin.x
    }
    set{
    self.frame.origin.x = newValue
    }
    }
    
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var color : UIColor{
        get{
            return self.textColor
        }
    }
}
