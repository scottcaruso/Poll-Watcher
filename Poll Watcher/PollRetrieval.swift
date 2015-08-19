//
//  PollRetrieval.swift
//  Poll Watcher
//
//  Created by Scott Caruso on 8/18/15.
//  Copyright © 2015 Scott Caruso. All rights reserved.
//

import Foundation

class PollRetrieval {
    
    let gopURL = NSURL(string:"http://elections.huffingtonpost.com/pollster/api/charts/2016-national-gop-primary")
    let demURL = NSURL(string:"http://elections.huffingtonpost.com/pollster/api/charts/2016-national-democratic-primary")
    
    var gopLeader: String
    var demLeader: String
    var gopPercentage: Double
    var demPercentage: Double
    
    init () {
        gopLeader = ""
        demLeader = ""
        gopPercentage = 0
        demPercentage = 0
    }
    
        
    func getLatestGopResults() -> (gopLeaderName: String, gopLeaderPercentage: Double) {
    
        let task = NSURLSession.sharedSession().dataTaskWithURL(gopURL!) { (data, response, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            do
            {
                let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let estimates: NSArray = jsonResult.valueForKey("estimates") as! NSArray
                let firstObject: NSDictionary = estimates[0] as! NSDictionary
                let polFirstName: NSString = firstObject.objectForKey("first_name") as! NSString
                let polLastName: NSString = firstObject.objectForKey("last_name") as! NSString
                let polPercentage: NSNumber = firstObject.objectForKey("value") as! NSNumber
                let polName = (polFirstName as String) + " " + (polLastName as String)
                self.gopLeader = polName
                self.gopPercentage = polPercentage as Double
            } catch
            {
                print("Oh noes! Bad things is happenin' up in here!")
            }
        }
        
        task.resume()
            
        return (self.gopLeader, self.gopPercentage)
    }
        
    func getLatestDemResults() -> (demLaderName: String, demLeaderPercentage: Double) {
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(demURL!) { (data, response, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            do
            {
                let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let estimates: NSArray = jsonResult.valueForKey("estimates") as! NSArray
                let firstObject: NSDictionary = estimates[0] as! NSDictionary
                let polFirstName: NSString = firstObject.objectForKey("first_name") as! NSString
                let polLastName: NSString = firstObject.objectForKey("last_name") as! NSString
                let polPercentage: NSNumber = firstObject.objectForKey("value") as! NSNumber
                let polName = (polFirstName as String) + " " + (polLastName as String)
                self.demLeader = polName
                self.demPercentage = polPercentage as Double
            } catch
            {
                print("Oh noes! Bad things is happenin' up in here!")
            }
        }
        
        task.resume()
        return (demLeader, demPercentage)
    }

}