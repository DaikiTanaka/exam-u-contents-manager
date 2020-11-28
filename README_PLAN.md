# 全体計画

## プロセス定義 → 見積

* 課題確認：0.5
* 全体計画：1.5
    * プロセス定義 → 見積
    * リスク評価
    * スケジュール
    * やらないことリスト
    * トレードオフ
    * Aチーム
    * テスト方針
    * 振り返り方針
    * レビュー方針
    * 連絡方針
* ゆる〜く設計：0.25
    * モデルの定義くらいはしておく
* 事前調査
    * grant_type が何になるかを確認：authorization_code：0.25
* 事前学習：0.25
* 環境構築(HelloWorldまで)：0.25
  * gitリポジトリ
  * README作成
  * gitignore
* 実装・テスト：※ 後述
* 受入テスト：1
* GitHub登録・アップロード：0.5
* 報告：0.25
    * 時間記録・集計を忘れずに！


### 実装・テストの見積

1. ログインページの作成：2
2. 写真一覧ページの作成：1.5
3. 写真アップロード画面：2
4. ログアウト機能：1
5. OAuth認可ページの表示：1
6. OAuthアクセストークンの取得：1
7. 連携アプリケーションへツイートを投稿：1


## スケジュール

* 11/27(金)：課題確認 〜 環境構築
* 11/28(土)：開発項目No.1~4
* 11/29(日)：開発項目No.5~7 〜 一式動く所までを送る
* 11/30(月)〜12/4(金)：FB対応期間
  * 来週の平日はあまり時間が取れなさそう
  * 質問事項のキャッチボールはこの期間で済ませる
* 12/5(土)〜12/6(日)：仕上げ・バッファ期間
  * 残件やFB事項があれば対応


## リスク評価

### スケジュール上のリスク要因

* 提供情報の誤り
    * すぐに確認 → OK
* gem不使用縛り
    * devise/sorceryナシ！
        * → gemのソースを見るなり、標準機能を調べて頑張る
        * → バッファ工数でカバー
    * carrierwaveナシ！
        * → gemのソースを見るなり、標準機能を調べて頑張る
        * → バッファ工数でカバー
    * Faradayナシ！
        * → gemのソースを見るなり、標準機能を調べて頑張る
        * → バッファ工数でカバー
    * RSpecナシ！
        * → 標準の Minitest で頑張る
    * Capybaraはアリ！！！
        * → 画面系も自動テストいける
    * Settingsナシ！
        * → constants.rb で定数として定義。今回はそこまでスピードに影響なさそう
* 外部サービスとの通信
    * エラーハンドリングどこまで真面目にやる？
        * 検証が大変なので今回はスキップ
* 6ヶ月ほどRailsを触っていなかった
    * 学習期間：最新版キャッチアップ(5との差分を中心に)
* Rubyのインストールには時間がかかるので、先に済ませておく


### 品質上のリスク要因

#### セキュリティ

* gem不使用縛り
    * devise：パスワード暗号化は自前で！

#### 負荷・応答速度

* 写真が増えた時に重くなる？
    * 要件は無し。検証の際は 5件 で進める。週明けに質問する。
* アクセス数は特に想定ナシ。気にせず作る！


# やらないことリスト

* フロントエンドはこだわらない
* UIの使い勝手の向上に関する提案はしない
* ドキュメントの整備はほどほどに：今回はスピード優先
  * 理解できているならわざわざ図を書いたりしない
  * 課題文に書いてあることはわざわざ書き直さない
* スクラムは無理にやらない。1人でやるものじゃない。でもベロシティは測りたい。スケジュールがタイトなので。
* 対応言語は日本語のみ


# トレードオフ

* Scope：Medium priority (最悪は全部揃わなくてもOKとのこと)
* Quality：Medium priority (テスト方面に注力)
* Cost：Low priority
* Delivery：High priority（納期が最優先！！！）


# Aチーム

* 田中D：メンバー
* 赤沼さん/採用担当者さん：PO
* エンジニアの皆さん：技術サポート？今回の課題内容なら聞く機会は少ないと思われる


# テスト方針

## テストレベル

* 単体：
  * INPUT：Rubyエンジニア選考課題.pdf（機能仕様書的な存在？）→ 頭の中で詳細設計したもの
  * OUTPUT：minitest
* 結合：
  * INPUT：Rubyエンジニア選考課題.pdf（機能仕様書的な存在？）
  * OUTPUT：minitest
* システム：
  * INPUT：Rubyエンジニア選考課題.pdf（機能仕様書的な存在？）
  * OUTPUT：minitest
* 受入：
  * INPUT：Rubyエンジニア選考課題.pdf（機能仕様書的な存在？）
  * OUTPUT：不具合が見つかったら minitestへケースを追加
  * 内容：モンキーテスト的に触ってみる

## 自動化方針

* 自動でやるもの
  * 単体：バリデーション(minitest)
  * 結合：未定
  * システム：画面系(minitest+capybara)
* 手動でやるもの
  * システム：外部サービス連携
  * ※ 無理な自動化はしない

## テスト環境

* Mac Catalina 10.15.7
* Safari


# 振り返り方針

* 開発項目を1つこなす度にベロシティを算出し直すこと
  * 予定が遅れそうであれば、POに伝えること
  * 予想とのギャップの理由を分析し、メモすること
  * Velocity管理票： https://docs.google.com/spreadsheets/d/1PHnG4_Hd5-V8WSrR6NAG_oZoQUoI_v4kh2OJQ1zFt7c/edit?usp=sharing


# レビュー方針

* 仕様レビュー：ナシ
* コードレビュー：提出後？
* テスト設計レビュー：提出後？


# 連絡方針

* 11/29(日)の作業終了時点で一旦 PO に連絡


# ゆる〜く設計

## モデル

* ユーザー(User)
    * ユーザー名(username)
    * 暗号化済みパスワード(encrypted_password)
* TwitterUser
    * ユーザー名(user_id) belongs_to で has_one する？
    * アクセストークン(access_token)
* 写真(Photo)
    * タイトル(title)
    * 写真URL(title)

## サービス

* ツイート外部連携(Tweet)

## 設定情報

* OAuth関連

## 足回り

* HTTPアクセス

## セッション

* ログインユーザID


# 事前学習

## ガイドを用意

必要なシーンで随時参照する方針。最初にまとまった時間はとらない。

* Ruby https://railsguides.jp/
* Rails https://docs.ruby-lang.org/ja/2.7.0/doc/index.html
* minitest https://github.com/seattlerb/minitest
* システムテスト https://api.rubyonrails.org/v6.0.3.4/classes/ActionDispatch/SystemTestCase.html
* OAuth https://tex2e.github.io/rfc-translater/html/rfc6749.html
* コーディング規約 https://www.ruby.or.jp/ja/tech/development/ruby/050_coding_rule.html


# 環境構築

## 公式で最新版を調べる

* Ruby https://www.ruby-lang.org/ja/
    * → 2.7.2
* Rails https://railsguides.jp/
    * → 6.x
* https://github.com/rbenv/rbenv#upgrading-with-homebrew
    * rbenvを更新、Ruby の 最新版をインストール


# リンク

* Velocity管理票：https://docs.google.com/spreadsheets/d/1PHnG4_Hd5-V8WSrR6NAG_oZoQUoI_v4kh2OJQ1zFt7c/edit?usp=sharing
* GitHub https://github.com/DaikiTanaka
