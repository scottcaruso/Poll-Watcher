//
//  ViewController.swift
//  Poll Watcher
//
//  Created by Scott Caruso on 8/18/15.
//  Copyright © 2015 Scott Caruso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gopLeaderData: (String,Double) = ("",0)
    var demLeaderData: (String,Double) = ("",0)
    var completeTimer: NSTimer?
    var polRetrieval: PollRetrieval?

    override func viewDidLoad() {
        
        polRetrieval = PollRetrieval()
        completeTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "checkForUpdate:", userInfo: nil, repeats: true)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForUpdate(timer: NSTimer)
    {
        if (gopLeaderData.0 == "" || gopLeaderData.1 == 0 || demLeaderData.0 == "" || demLeaderData.1 == 0)
        {
            gopLeaderData = polRetrieval!.getLatestGopResults()
            demLeaderData = polRetrieval!.getLatestDemResults()
            print("Nothing yet")
        } else
        {
            print(gopLeaderData)
            print(demLeaderData)
            timer.invalidate()
        }
    }

}

