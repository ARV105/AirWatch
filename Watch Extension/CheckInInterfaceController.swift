//
//  CheckInInterfaceController.swift
//  Watch Extension
//
//  Created by Vilaire, Auriel Robert on 9/21/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {
  
  @IBOutlet var backgroundGroup: WKInterfaceGroup!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!

  var flight: Flight? {
    didSet {
      guard let flight = flight else { return }
      
      originLabel.setText(flight.origin)
      destinationLabel.setText(flight.destination)
    }
  }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
      if let flight = context as? Flight {
        self.flight = flight
      }
    
    }

//IB Action
  
  @IBAction func checkInButtonTapped() {
  
  // 1
  let duration = 0.35
  let delay = DispatchTime.now() + (duration + 0.15)
  // 2
  backgroundGroup.setBackgroundImageNamed("Progress")
  
  //3
  backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10), duration: duration, repeatCount: 1)
  //4
  DispatchQueue.main.asyncAfter(deadline: delay) { [weak self] in
  self?.flight?.checkedIn = true
  self?.dismiss()
  }

}

}
