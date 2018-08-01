// Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at http://aws.amazon.com/apache2.0/
// or in the "license" file accompanying this file.
// This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

class ViewController: UIViewController, AmazonAdInterstitialDelegate {

    var interstitial: AmazonAdInterstitial!
    @IBOutlet var loadAdButton: UIButton!
    @IBOutlet var showAdButton: UIButton!
    @IBOutlet var loadStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = AmazonAdInterstitial()
        
        interstitial.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loadAmazonInterstitial(_ sender: UIButton) {
        loadStatusLabel.text = "Loading Interstitial..."
        
        let options = AmazonAdOptions()
        
        options.isTestRequest = true
        
        interstitial.load(options)
    }

    @IBAction func showAmazonInterstitial(_ sender: UIButton) {
        interstitial.present(from: self)    
    }
    
// Mark: - AmazonAdInterstitialDelegate    
    func interstitialDidLoad(_ interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.")
        loadStatusLabel.text = "Interstitial loaded."
    }
    
    func interstitialDidFail(toLoad interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.")
        loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(_ interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.")
    }
    
    func interstitialDidPresent(_ interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.")
    }

    func interstitialWillDismiss(_ interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.")
    }
    
    func interstitialDidDismiss(_ interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.");
        self.loadStatusLabel.text = "No interstitial loaded.";
    }
}

