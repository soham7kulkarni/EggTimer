//
//  ViewController.swift
//  EggTimer
//
//

import UIKit

//Importing 'AVFoundation' module to play sound
import AVFoundation

class ViewController: UIViewController {
    
//Declaring dictionary 'eggTimes' for quick retrieval of values
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard" : 7]

    var player: AVAudioPlayer?
    
// Creating object of Timer to stop previous time when we hit the action button for any new egg
    var timer = Timer()
    
//Creating outlet for different components because we want to work with them.
//Name of the outlet helps us in exact access to different attributes.
//Clicking on grey dots will help identify the pair of outlet and respective component.
    
//Outlet for label for 'Title Label' from 'Title View'
    @IBOutlet weak var titleLabel: UILabel!
    
//Outlet for label for 'Progress Bar' from 'Timer View'
    @IBOutlet weak var progressBar: UIProgressView!
    
//Linking all 3 buttons 'Soft Egg Button' , 'Medium Egg Button' , 'Hard Egg Button' to single IBAction 'hardnessSelected'
//Hover over grey dot will reflect all 3 buttons
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
// As we have clicked 1 of the 3 button for fresh activity we will call invalidate method of the timer to stop any ongoing/previous timer.
        timer.invalidate()
//Title of all 3 buttons 'Soft', 'Medium', 'Hard' distinguishes them from each other hence accessing titles using currentTitle method
//This title may have nil value hence it is declared optional type by compiler.
//We have to unwrap it using ! since we know it will have any one value
        let hardness = sender.currentTitle!
//Accessing values from dictionary using hardness constant. Again using ! since keys are also optional
//Remove ! from code and read the errors
        let result = (eggTimes[hardness])!
        print(result)
        
//varibles for calculating progress and timer
        var secondPassed = 1
        var progressPercentage = 0.0
        
//After fresh click of any button progress should set to 0
//We will let user know what type of egg they have clicked by updating value of titleLabel using hardness
        progressBar.progress = 0.0
        titleLabel.text = hardness
        
//Standard implementation of timer
//We want to update our timer after 1 second and we don't want it once but till the end. Hence Parameter values are 1.0 and true
//We need to apply same data type either Double or float to both of the variables or else we will receive truncated result

        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondPassed <= result {
// For example 1/3 = 0.33 but we will receive whole number i.e 0 and hence progress bar will never advance
                progressPercentage = (Double(secondPassed)/Double(result))
//Print statements are for debugging purpose to check behind-the-scene calculations
                print("\(secondPassed) seconds passed")
                print("\(progressPercentage) progress done")
//progress of attributes require float hence type casting
                progressBar.progress = Float(progressPercentage)
                secondPassed += 1
                
                
            } else {
//We enter else block when timer is done hence we will invalidate the timer and update the screen with "DONE!"
                Timer.invalidate()
                titleLabel.text = "DONE!"

//Standard implementation of implementing sound
//Putting this in else block to receive sound after completion of timer/activity
//Adjust forResource and ofType with filename and extension
                func playSound() {
                    guard let path = Bundle.main.path(forResource: "audio", ofType:"mp3") else {
                        return }
                    let url = URL(fileURLWithPath: path)
                    
                    do {
                        player = try AVAudioPlayer(contentsOf: url)
                        player?.play()
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
//Calling the function is imp after declaration
                playSound()
            }
            
        }
        
    }
    
}
