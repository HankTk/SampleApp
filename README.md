# SampleApp

SwiftUIを使用したサンプルアプリケーションです。様々なUIコンポーネントと機能の実装例を提供します。

## 概要

このアプリは、SwiftUIの様々な機能を学習・検証するためのサンプル集です。9つの異なるテストビューを通じて、基本的なUIコンポーネントから高度な機能までを実装しています。

## 機能

### Test 1: Hello World
基本的なテキスト表示のサンプルです。

### Test 2: サイコロ
ランダムなサイコロの目を表示するインタラクティブなビューです。ボタンをタップするとサイコロが振られ、1から6のランダムな数字が表示されます。

### Test 3: ランダム数字選択
1から60の数字から重複なしで2つのランダムな数字を選択して表示します。

### Test 4: 図形レイアウト
様々な図形のレイアウトと配置のサンプルです。

### Test 5: 地図表示
地図表示機能のサンプルです。

### Test 6: 画像ピッカー
画像選択機能のサンプルです。

### Test 7: 郵便番号検索
郵便番号検索機能のサンプルです。

### Test 8: UIコンポーネント
様々なUIコンポーネントの実装例です。

### Test 9: 動画プレーヤー
動画再生機能のサンプルです。

## 技術スタック

- **言語**: Swift
- **フレームワーク**: SwiftUI
- **開発環境**: Xcode
- **プラットフォーム**: iOS

## プロジェクト構造

```
SampleApp/
├── SampleApp/
│   ├── SampleApp.swift          # アプリのエントリーポイント
│   ├── MainView.swift           # メインビュー（テスト一覧）
│   ├── Previewable.swift        # プレビュー用プロトコル
│   ├── Test1View.swift          # Test 1: Hello World
│   ├── Test2View.swift          # Test 2: サイコロ
│   ├── Test3View.swift          # Test 3: ランダム数字選択
│   ├── Test4View.swift          # Test 4: 図形レイアウト
│   ├── Test5View.swift          # Test 5: 地図表示
│   ├── Test6View.swift          # Test 6: 画像ピッカー
│   ├── Test7View.swift          # Test 7: 郵便番号検索
│   ├── Test8View.swift          # Test 8: UIコンポーネント
│   ├── Test9View.swift          # Test 9: 動画プレーヤー
│   ├── Sample.mp4               # サンプル動画ファイル
│   └── Assets.xcassets/         # アセットカタログ
├── SampleAppTests/              # ユニットテスト
└── SampleAppUITests/            # UIテスト
```

## 主な特徴

### Previewable プロトコル
`Previewable`プロトコルを実装することで、各ビューに対して自動的にプレビューを生成できます。これにより、Xcodeのプレビュー機能を効率的に活用できます。

```swift
protocol Previewable: View {
    static var previewName: String { get }
    static var previewWrappedInNavigation: Bool { get }
    init()
}
```

## セットアップ

1. このリポジトリをクローンまたはダウンロードします
2. Xcodeで`SampleApp.xcodeproj`を開きます
3. シミュレーターまたは実機を選択します
4. ビルドして実行します（⌘ + R）

## 要件

- Xcode 14.0以上
- iOS 16.0以上
- Swift 5.7以上

## ライセンス

このプロジェクトは個人の学習・検証目的で作成されています。

## 作成者

Hidenori Takaku

## 更新履歴

- 2024/12/27 - 初版作成
