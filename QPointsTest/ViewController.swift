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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendEnterMDPressed(sender: UIButton) {
        
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
                err: NSError!) in
                
                /* Now we may have access to the data but check if an error came back
                first or not */
                if data.length > 0 && err == nil{
                // let html = NSString(data: data, encoding:NSUTF8StringEncoding)
                    let html: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    println(html["nr"]!)
                    dispatch_async(dispatch_get_main_queue(),{
                        self.displayResponseField.text = "\(html)"
                    });
                } else if data.length == 0 && err == nil{
                    println("Nothing was downloaded")
                } else if err != nil{
                    println("Error happened = \(err)")
                }
            }
        )
    }

    
}

