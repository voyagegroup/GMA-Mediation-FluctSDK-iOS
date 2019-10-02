//
//  VideoRewardViewController.swift
//  GMAMediationFluctSDK
//

import UIKit
import GoogleMobileAds

import FluctSDK
import GoogleMobileAdsMediationFluct

private let videoRewardedAdUnitID = "/62532913/a_fluct.test_1024x768_kosugetest_11940"

class VideoRewardViewController: UIViewController {

    @IBOutlet
    weak var loadButton: UIButton?

    @IBOutlet
    weak var playButton: UIButton?

    private var isRewarded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadButton?.isEnabled = true
        playButton?.isEnabled = false
    }

}

// MARK: - IBAction
extension VideoRewardViewController {

    @IBAction
    func touchLoadButton(_ button: UIButton) {
        loadButton?.isEnabled = false
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        let setting = FSSRewardedVideoSetting.default
        setting.isDebugMode = true
        // 配信したくないADNWを無効にする
        setting.activation.isAdCorsaActivated = false
        setting.activation.isUnityAdsActivated = false
        let targeting = FSSAdRequestTargeting()
        targeting.age = 30
        let extra = GADMAdapterFluctExtras()
        extra.setting = setting
        extra.targeting = targeting
        let request = DFPRequest()
        request.register(extra)
        GADRewardBasedVideoAd.sharedInstance().load(request, withAdUnitID: videoRewardedAdUnitID)
    }

    @IBAction
    func touchPlayButton(_ button: UIButton) {
        if GADRewardBasedVideoAd.sharedInstance().isReady {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }

}

// MARK: - GADRewardBasedVideoAdDelegate
extension VideoRewardViewController: GADRewardBasedVideoAdDelegate {

    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        loadButton?.isEnabled = true
        playButton?.isEnabled = true
        print("rewardBasedVideoAd.adNetworkClassName:   \(rewardBasedVideoAd.adNetworkClassName ?? "nil")")
    }

    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        loadButton?.isEnabled = true
        playButton?.isEnabled = false

        let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
    }

    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        playButton?.isEnabled = false
        let messaage = isRewarded ? "報酬を受け取りました" : "報酬は受け取れませんでした"
        let alert = UIAlertController(title: "結果", message: messaage, preferredStyle: .alert)
        let action = UIAlertAction(title: "閉じる", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
    }

    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        isRewarded = true
    }

}
