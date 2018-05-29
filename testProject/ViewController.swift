//
//  ViewController.swift
//  testProject
//
//  Created by Bogdan Barbulescu on 29/05/2018.
//  Copyright © 2018 Bogdan Barbulescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stringDates = [String]()
    
    var displayedDate = Date() {
        didSet {
            self.getNextDays()
        }
    }
    
    
    var dateNow: Date {
        return Date()
    }
    

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    
    func updateUI() {
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        self.getNextDays()
        

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .UIApplicationDidBecomeActive, object: nil)

        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
  
        self.getNextDays()

    }


}


extension ViewController {
    
    //for each segment, construct a string date with the currentDate() being first, followed by 5 consecutive days
    func getNextDays()  {
        
        stringDates.removeAll()
        
        
        
        for i in 0...5 {
            let dateFormatter = DateFormatter()
            let today = dateNow
            let calendar = Calendar.current
            
            if i == 0 {
                let dayComponent = Calendar.current.component(.weekday,from: today)
                let day = Calendar.current.component(.day, from: today) //Int
                let dayString = dateFormatter.shortWeekdaySymbols[dayComponent-1] //Symbol
                
                
                let month = Calendar.current.component(.month, from: today)
                let monthSymbol = dateFormatter.shortMonthSymbols[month-1]
                let dayMonthString =  dayString + " " + String(day) + " " + monthSymbol
                stringDates.append(dayMonthString)
                
                
            } else {
                var components = DateComponents()
                components.weekday = i
                
                let nextDay = calendar.date(byAdding: components, to: today)
                let nextDayComponent = Calendar.current.component(.weekday,from: nextDay!)
                let day = Calendar.current.component(.day, from: nextDay!)
                let dayString = dateFormatter.shortWeekdaySymbols[nextDayComponent-1] // Symbol
                
                
                let month = Calendar.current.component(.month, from: nextDay!)
                let monthSymbol = dateFormatter.shortMonthSymbols[month-1]
                let dayMonthString = dayString + " " + String(day) + " " + monthSymbol
                stringDates.append(dayMonthString)
            }
        }
        
        
        //set the title for each segment from stringDates array
        for value in 0...5 {
            self.segmentedControl.setTitle(self.stringDates[value], forSegmentAt: value)
        }
    } //end of getNextDays()
    

    
}







