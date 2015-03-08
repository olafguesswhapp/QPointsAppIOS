//
//  ViewController.swift
//  QPointsTest
//
//  Created by Olaf Peters on 06.03.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterMDfield: UITextField!
    @IBOutlet weak var displayResponseField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("hier sind wir")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendEnterMDPressed(sender: UIButton) {
        println(enterMDfield.text)
        
        let httpMethod = "POST"
        let timeout = 15
        let urlAsString = "http://localhost:3000/apireceiverequest"
        let url = NSURL(string: urlAsString)
        let urlRequest = NSMutableURLRequest(URL: url!,
            cachePolicy:
            .ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
        
        urlRequest.HTTPMethod = httpMethod
        
        let body = "reqInput=\(enterMDfield.text)".dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: false)
        
        urlRequest.HTTPBody = body
        
        let queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest,
            queue: queue,
            completionHandler: {(response: NSURLResponse!,
                data: NSData!,
                error: NSError!) in
                
                /* Now we may have access to the data but check if an error came back
                first or not */
                let typeLongName = _stdlib_getDemangledTypeName(data)
                let tokens = split(typeLongName, { $0 == "." })
                if let typeName = tokens.last {
                    println("Type \(typeName).")
                }
                // if data.length > 0 && error == nil{
                if let html = data {
                let html = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("html = \(html!)")
                    dispatch_async(dispatch_get_main_queue(),{
                        self.displayResponseField.text = "\(html!)"
                        });
                } else if data.length == 0 && error == nil{
                    println("Nothing was downloaded")
                } else if error != nil{
                    println("Error happened = \(error)")
                }
            }
        )
    }

    
}

