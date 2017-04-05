//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Aaron Thomas on 15/01/2017.
//  Copyright © 2017 Aaron Thomas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }
    
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
        btnSound.stop()
        }
    btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
    if currentOperation != Operation.Empty {
    
    if runningNumber != "" {
        rightValStr = runningNumber
        runningNumber = ""
        
        if currentOperation == Operation.Multiply{
            result = "\(Double(leftValStr)! * Double(rightValStr)!)"
        } else if currentOperation == Operation.Divide {
            result = "\(Double(leftValStr)! / Double(rightValStr)!)"
        } else if currentOperation == Operation.Subtract {
            result = "\(Double(leftValStr)! - Double(rightValStr)!)"
        } else if currentOperation == Operation.Add {
            result = "\(Double(leftValStr)! + Double(rightValStr)!)"
        }
        leftValStr = result
        outputLbl.text = result
    }
        currentOperation = operation
    } else {
        leftValStr = runningNumber
        runningNumber = ""
        currentOperation = operation
        }
}
    
    @IBAction func clearBtn(_ sender: Any) {
        outputLbl.text = ""
        currentOperation = Operation.Empty
        playSound()
    }
    
}
