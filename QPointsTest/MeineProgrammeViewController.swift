//
//  MeineProgrammeViewController.swift
//  QPointsTest
//
//  Created by Olaf Peters on 28.03.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class MeineProgrammeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableVIew: UITableView!
    
    var programs:[Programs] = []
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showProgramDetail" {
            let detailVieCon: ProgramDetailViewController = segue.destinationViewController as ProgramDetailViewController
            let indexPath = self.tableVIew.indexPathForSelectedRow()
            let thisProgram = programs[indexPath!.row]
            detailVieCon.detailProgram = thisProgram
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.programs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let programInfo = programs[indexPath.row]
        
        var cell: programTableViewCell = tableView.dequeueReusableCellWithIdentifier("programCell") as programTableViewCell
        
        cell.ProgramNameField.text = programInfo.programName
        cell.ProgramPointsField.text = "\(programInfo.myCount) / \(programInfo.programGoal)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showProgramDetail", sender: self)
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
            self.tableVIew.reloadData()
        })
        task.resume()
    }

}
