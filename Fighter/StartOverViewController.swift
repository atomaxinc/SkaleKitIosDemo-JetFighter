//
//  StartOverViewController.swift
//  Fighter
//
//  Created by Ryan on 2017/3/16.
//  Copyright © 2017年 Atomax. All rights reserved.
//

import UIKit

protocol StartOverViewControllerDelegate {
    func didClickStartOverButton(_ viewController : StartOverViewController);
}

class StartOverViewController: UIViewController {

    var delegate : StartOverViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didClickStartOver(_ sender: Any) {
        
        self.delegate?.didClickStartOverButton(self)
        
    }
}
