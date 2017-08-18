//
//  ViewController.swift
//  chess
//
//  Created by JOHN KENNY on 06/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    ///ui elemenets
    @IBOutlet var panOutlet: UIPanGestureRecognizer!

    @IBOutlet var checkedLab: UILabel!
    @IBOutlet var turnLab: UILabel!
    
    var piceDragged: UIChessPiece!
    var sourceOrgin: CGPoint!
    var destOrigin: CGPoint!
    static var spaceFromLeftEdge = 8
    static var spaceFromTopEdge = 132
    static var tileSize = 38
    
    var myGame : ChessGame!
    var chessPieces : [UIChessPiece]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

