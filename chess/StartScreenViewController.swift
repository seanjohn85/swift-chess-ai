//
//  StartScreenViewController.swift
//  chess
//
//  Created by JOHN KENNY on 28/08/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC =  segue.destination as! ViewController
        
        
        if segue.identifier == "singlePlayer" {
            destVC.isAgainstAI = true
        }else{
            destVC.isAgainstAI = false
        }
        
    }

    @IBAction func unwind(seg: UIStoryboardSegue){
        
    }
 

}
