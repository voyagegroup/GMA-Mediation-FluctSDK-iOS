# GMA Mediation FluctSDK iOS

Google AdManagerのメディエーションする実装サンプルです

## 環境

```
iOS: 13
xcode:  10.3
Swift:  5.1
CocoaPods: 1.8.1  
```

## 使用しているFrameworkのバージョン

```
FluctSDK: 5.13.0
FluctSDK-MediationAdapter: 5.13.0
Google-Mobile-Ads-SDK: 7.51.0
```

## 環境構築

```sh
$ git clone git@github.com:voyagegroup/GMA-Mediation-FluctSDK-iOS.git
$ cd GMA-Mediation-FluctSDK-iOS
$ pod install
$ open GMAMediationFluctSDK.xcworkspace
```

## 実装上の注意

### テスト用AdUnitIDについて

- 動画リワード / 動画インタースティシャルのサンプルで使用しているAdUnitIDは本番では使わないでください
- FluctSDKの動画リワードが流れるように設定をしているAdUnitIDになりますので、AdXの動画リワードの再生率はかなり低くなっています
- FluctSDKで再生される動画インタースティシャルはサンプルなので、skippableになっていない広告が再生される可能性もあります

### Info.plistに追記で必要

```
<key>GADIsAdManagerApp</key>
<true/>
```

はGoogle AdManagerを使用する上で必須の記述となります。

`Info.plist`に追記をお願いします。

この記述がないと起動時にクラッシュするのでお気をつけください。

## 各種リンク

FluctSDKのWikiに実装に必要なリンクをまとめてあるので、そちらをご覧ください。

[Google Mobile Ads SDKのカスタムイベントクラスの導入方法 · voyagegroup/FluctSDK-iOS Wiki](https://github.com/voyagegroup/FluctSDK-iOS/wiki/Google-Mobile-Ads-SDK%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%A0%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%AE%E5%B0%8E%E5%85%A5%E6%96%B9%E6%B3%95)

## メディエーション先SDKについて

maio（1.5.0以降）とAdColony（4.1.2.以降）はXcode10ではbuild出来ません。
開発環境はXcode10系の場合はPodfileに書かれている通り、以下のバージョンを指定してください。

```ruby
pod 'AdColony', '4.1.1'
pod 'MaioSDK', '1.4.8'
```

このプロジェクトはXcode10.3で動くようにしているため、バージョンを下げて対応しています。
