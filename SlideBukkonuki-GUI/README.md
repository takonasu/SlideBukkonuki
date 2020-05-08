# SlideBukkonuki-GUI
[たこなす様](https://twitter.com/ITF_tako)作成のスライドぶっこ抜きマンをGUI化しました。[GitHub](https://github.com/takonasu/SlideBukkonuki)

ダウンロードは[こちら](https://github.com/takpika/SlideBukkonuki-GUI/releases)
※ベータ版です。動作を保証していません。

# インストール方法
同梱のinstall.commandを実行すると、自動で必要なドライバのインストールが始まります。

画面の指示に従って操作してください。（英語です。ターミナル画面です。マウスは使えません。）

install.commandが実行できない人はターミナルで以下のコマンドを実行してください。（Homebrewがインストールされていない人向けのコマンドです。）
```
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install opencv
```
※OpenCVが既にインストールされている場合はこの作業は必要ありません。
[参考URL](https://qiita.com/pypypyo14/items/4bf3b8bd511b6e93c9f9)

# 対応OS
macOS Catalina 10.15以上

# 動作確認環境
Mac mini Late 2014: macOS Catalina 10.15.4

MacBook Pro 13' 2019: macOS Catalina 10.15.4

# FAQ
Q. 「ぶっこ抜く！」を押してフォルダを選択したあとフリーズする。

A. 仕様です。修正予定ではあります。

# クレジット
開発者: [takpika](https://twitter.com/takpika0308)

デザイン: [SGO](https://twitter.com/SGO_ITF)

# その他
アプリ開発はほぼ初心者なので、色々とバグがあります。今後修正はしていく予定なので少々お待ちを…。何かあれば[こちら](https://github.com/takpika/SlideBukkonuki-GUI/issues)にご連絡ください。

バグ修正が終わり次第、リリース版にしようと考えています。
