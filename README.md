# QuizProject

# アプリケーション概要
ITの問題を答えながらITについて学べることができるiOSアプリ(iPhone, iPad)

# 仕様技術

- Xcode Ver: 14.1
- Swift Ver: 5.7.1 
- ライブラリ管理 CocoaPods, SPM(Realm)

- DB
  - Realm Ver: 10.38.0
  - GRDB  Ver: 6.10.2

- API通信
  - Alamofire Ver: 5.6.4

- その他
  - PKHUD Ver: 5.3.0
 
# 実装

- 2パターンの作り方で実装
    - パターン1： 非同期処理はGCDで、UIはUIKitで実装
      - https://github.com/yosshi0127-ios/QuizProject/tree/main/QuizProjectInUIKit
      
    - パターン2： 非同期処理はSwift Concurrencyで、UIはSwiftUIで実装
      - https://github.com/yosshi0127-ios/QuizProject/tree/main/QuizProjectInSwiftUI

# アプリケーション仕様

## 機能概要

- QuizAPI https://quizapi.io/ が提供するクイズの出題、回答ができる
    - カテゴリを選択し、選択したカテゴリの問題に挑戦できる
- 挑戦履歴機能として、挑戦時の結果（出題、回答、正誤）と成績（正解数、正答率）が端末ローカルに記録され、オフラインで閲覧することができる

## API仕様

### ドキュメント

https://quizapi.io/docs/1.0/overview

### 問題取得

#### リクエスト仕様

- GETリクエスト
- パスは`/api/v1/questions`
- クエリパラメータ
    - `category`でカテゴリを指定（指定しない場合は全てを対象）
    - `limit`で一度に取得する件数を指定

#### レスポンス仕様

[ドキュメント](https://quizapi.io/docs/1.0/random-quiz)参照。

## 実装機能

- トップ画面
    - 起動後はトップ画面に遷移
- ジャンル選択画面
- 問題挑戦画面
- 履歴画面
- 結果画面

各画面の詳細は以下。

## トップ画面

- 以下の2つのボタンを表示
    - 「クイズに挑戦」ボタン
    - 「挑戦履歴」ボタン
    
<img src="ReadmeResource/img/topScreen.PNG" width="320px">   

## ジャンル選択画面

- 以下の選択肢を固定で表示する
    - All
    - Code
    - Docker
    - Linux
    - SQL
- 選択すると、[問題取得のAPI](#問題取得)で問題の取得を行う
    - クエリパラメータ`limit`に`10`を指定し、10件要求する
    
<img src="ReadmeResource/img/genreScreen.PNG" width="320px">   

## 問題挑戦画面

- 問題データを表示を行う
- 問題数分、1問ずつ「問題表示」と「正解表示」を切り替える
- 択一選択問題か、複数選択問題なのかを表示する
    - 択一選択の場合
        - 同時に選択できる選択肢を最大1つにする（ある選択肢を選択した場合、以前の選択肢は選択解除とする）
        - 何も選択していない状態で回答ボタンは非活性とする
    - 複数選択の場合
        - ある選択肢を選択した場合、その選択肢の選択状況が反転する
        - 常に回答ボタンは活性とする
    - 回答ボタン
        - 押下で正解表示に切り替える
- 正解表示
    - 問題文、択一選択なのか複数選択なのかの表示、選択肢表示は問題表示の場合と同様
    - 正解か不正解かの表示を行う
    - 正答である選択肢を正答選択肢用の色にする
    - 正解の解説文`explanation`を表示する
    - 次へボタン
    - 結果ボタン
- 履歴追加処理
    - ローカルDBに履歴を追加する

https://user-images.githubusercontent.com/105440671/235298487-db376995-3bd6-4b9e-958c-b94571860973.mp4

## 結果画面

- 選択ジャンル、問題数、正解数、正答率を表示
- 各問題について以下の表示
    - 問題文
    - 択一選択なのか複数選択なのか
    - 選択肢の文字列
    - 回答状態
    - 正答
    - 正解であったか否か
    - 正解の解説文
- 問題挑戦画面から遷移している場合は、トップに戻るボタンを表示
    - 履歴画面から遷移している場合は、ナビゲーションの戻る操作で戻る

https://user-images.githubusercontent.com/105440671/235298608-8642ff03-be01-4c99-89bb-8b7690674314.mp4

## 履歴画面

- ローカルDBから挑戦の履歴情報を参照し、リスト表示
- 挑戦ごとに以下の表示
    - 挑戦日時
    - 選択ジャンル
    - 問題数、正解数、正解率
    - セル選択で、結果画面に遷移

https://user-images.githubusercontent.com/105440671/235298615-3d78f360-f1dc-4267-84a8-f86269d880de.mp4
