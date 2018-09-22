//
//  ScheduleInterfaceController.swift
//  Watch Extension
//
//  Created by Vilaire, Auriel Robert on 9/21/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


var flights = Flight.allFlights()
var selectedIndex = 0

class ScheduleInterfaceController: WKInterfaceController {

  @IBOutlet weak var flightsTable: WKInterfaceTable!
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    for index in 0..<flightsTable.numberOfRows {
      guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
      
      controller.flight = flights[index]
  }
  
  }
  
  override func didAppear() {
    super.didAppear()
    //1
    guard flights[selectedIndex].checkedIn,
      let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    
    // 2
    animate(withDuration: 0.35) {
      // 3
      controller.updateForCheckIn()
    }
  }
  
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = ["Flights", "CheckIn"]
    selectedIndex = rowIndex
    presentController(withNames: controllers, contexts: [flight, flight])
  }
}
