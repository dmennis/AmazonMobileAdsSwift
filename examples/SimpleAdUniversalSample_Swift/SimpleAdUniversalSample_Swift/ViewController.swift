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

class ViewController: UIViewController, AmazonAdViewDelegate {

    @IBOutlet var loadAdButton: UIButton!
    @IBOutlet var amazonAdView: AmazonAdView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAmazonAd(loadAdButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context) -> Void in
            // Reload Amazon Ad upon rotation.
            // Important: Amazon expandable rich media ads target landscape and portrait mode separately.
            // If your app supports device rotation events, your app must reload the ad when rotating between portrait and landscape mode.
            self.loadAmazonAd(self.loadAdButton);
        });
    }
    
    @IBAction func loadAmazonAd(_ sender: UIButton){
        if ((amazonAdView) != nil) {
            amazonAdView.removeFromSuperview()
            amazonAdView = nil
        }
        
        // Initialize Auto Ad Size View
        let adFrame: CGRect = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 90);
        amazonAdView = AmazonAdView.init(frame: adFrame)
        amazonAdView.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        amazonAdView.setHorizontalAlignment(.center)
        amazonAdView.setVerticalAlignment(.fitToContent)
        
        // Register the ViewController with the delegate to receive callbacks.
        amazonAdView.delegate = self
       
        // Set Ad Loading Options & Load Ad
        let options = AmazonAdOptions()
        options.isTestRequest = true
        amazonAdView.loadAd(options)
    }
    
    // MARK: AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(_ view: AmazonAdView!) -> Void {
        // Add the newly created Amazon Ad view to our view.
        self.view.addSubview(amazonAdView)
    }
    
    func adViewDidFail(toLoad view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        Swift.print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(_ view: AmazonAdView!) -> Void {
        Swift.print("Ad will expand")
    }
    
    func adViewDidCollapse(_ view: AmazonAdView!) -> Void {
        Swift.print("Ad has collapsed")
    }
    
    
}

