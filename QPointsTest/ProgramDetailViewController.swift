//
//  ProgramDetailViewController.swift
//  QPointsTest
//
//  Created by Olaf Peters on 28.03.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {

    @IBOutlet weak var ProgramNameField: UILabel!
    @IBOutlet weak var ProgramPointsField: UILabel!
    @IBOutlet weak var ProgramGoalField: UILabel!
    
    var detailProgram: Programs!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ProgramNameField.text = detailProgram.programName
        self.ProgramPointsField.text = "\(detailProgram.myCount)"
        self.ProgramGoalField.text = "\(detailProgram.programGoal)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
