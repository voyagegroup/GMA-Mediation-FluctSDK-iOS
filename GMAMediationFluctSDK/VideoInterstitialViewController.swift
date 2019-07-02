//
//  VideoInterstitialViewController.swift
//  GMAMediationFluctSDK
// VideoInterstitialViewController
//

import UIKit
import GoogleMobileAds

private let videoInterstitialAdUnitID = "/62532913/a_fluct.test_1024x768_kosugetest.interstitial_11940"

class VideoInterstitialViewController: UIViewController {
    
    @IBOutlet
    weak var loadButton: UIButton?
    
    @IBOutlet
    weak var playButton: UIButton?
    
    private var interstitial: DFPInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadButton?.isEnabled = true
        playButton?.isEnabled = false

        title = "動画インタースティシャル"
    }
    
}

// MARK: - IBAction
extension VideoInterstitialViewController {
    
    @IBAction
    func touchLoadButton(_ button: UIButton) {
        loadButton?.isEnabled = false

        let interstitial = DFPInterstitial(adUnitID: videoInterstitialAdUnitID)
        interstitial.delegate = self
        self.interstitial = interstitial
        interstitial.load(DFPRequest())
    }
    
    @IBAction
    func touchPlayButton(_ button: UIButton) {
        if let interstitial = self.interstitial, interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    
}

// MARK: - GADInterstitialDelegate
extension VideoInterstitialViewController: GADInterstitialDelegate {

    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        loadButton?.isEnabled = true
        playButton?.isEnabled = true
    }

    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        loadButton?.isEnabled = true
        playButton?.isEnabled = false

        let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        playButton?.isEnabled = false
        interstitial = nil
    }

}
