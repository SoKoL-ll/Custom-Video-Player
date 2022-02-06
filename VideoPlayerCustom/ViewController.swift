//
//  ViewController.swift
//  VideoPlayerCustom
//
//  Created by SoKoL on 03.02.2022.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var stringUrl: String = ""
    @IBOutlet weak var url: UITextField!
    @IBAction func startButton(_ sender: UIButton) {
        url.endEditing(true)
        if (verifyUrl(urlString: url.text)) {
            stringUrl = url.text!
            performSegue(withIdentifier: "show", sender: self)
        } else {
            let errorMessageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "messageVCid") as! ErrorMessageViewController
            self.addChild(errorMessageVC)
            errorMessageVC.view.frame = self.view.frame
            self.view.addSubview(errorMessageVC.view)
            errorMessageVC.didMove(toParent: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let playerViewController = PlayerView()
    func play() {
        stringUrl = url.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let destinationVC = segue.destination as! ShowVideoViewController
            destinationVC.url = stringUrl
        }
    }
    
    private func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}



