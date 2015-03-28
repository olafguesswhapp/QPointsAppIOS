//
//  ViewController2ViewController.swift
//  QPointsTest
//
//  Created by Olaf Peters on 15.03.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class ViewController2ViewController: UIViewController {
    
    
    @IBOutlet weak var programNr: UILabel!
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programGoal: UILabel!
    @IBOutlet weak var programCount: UILabel!
    
    var programs:[Programs] = []
    var displayProgramsCounter:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestProgramData()
        println("ProgramData received")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestProgramPressed(sender: UIButton) {
        if displayProgramsCounter == self.programs.count - 1 {
            displayProgramsCounter = 0
        } else {
            displayProgramsCounter += 1
        }
        displayProgram(displayProgramsCounter)
        
    }
    func requestProgramData() {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/apirequestprograms")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = [
            "userId" : "j2@guesswhapp.de"]
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, err) -> Void in
            var conversionError: NSError?
            var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: &conversionError) as? NSDictionary
            for var i=0; i < (jsonDictionary!["programs"]!.count); i++ {
                var programs = Programs()
                programs.nr = jsonDictionary!["programs"]![i]!["nr"] as String
                programs.programName = jsonDictionary!["programs"]![i]!["programName"] as String
                programs.programGoal = jsonDictionary!["programs"]![i]!["goalCount"] as Int
                programs.myCount = jsonDictionary!["programs"]![i]!["count"] as Int
                self.programs += [programs]
                }
            self.displayProgram(0)
        })
        task.resume()
    }
    
    func displayProgram(itemNr: Int) {
        println("Should Print now \(itemNr)")
        let program = programs[itemNr]
        self.programNr.text =  program.nr
        self.programName.text = program.programName
        self.programGoal.text = String(program.programGoal)
        self.programCount.text = String(program.myCount)
    }

}

