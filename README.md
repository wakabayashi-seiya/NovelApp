# 概要

[ビブリオテック](https://bibliothequebooks.herokuapp.com/)は、誰でも気軽に小説を読んだり、書いたりできるアプリです。

# 実装機能(使用している技術)

## ユーザー関連

* ユーザーの登録/編集/削除(Devise + Bcrypt)

* 管理ユーザー機能(rails_admin + cancancan) 

* Twitter認証機能(Devise + OmniAuth)

## 小説関連

* 小説の新規作成/編集/削除

* 小説の表紙設定(Carrierwave + fogでAWSのS3に画像をアップロードする形です)

* エピソードの執筆/編集/削除(WYSIWYGエディターとして、summernoteを使用)

* 小説を本棚(お気に入り)に追加/外す機能(Ajax)

* 本棚に追加した小説の更新情報の受信機能

* 小説の検索機能

* ランキング表示機能

* ページネーション機能(will_paginate)

* 小説をSNSで共有(react-share) 


## コメント関連

* 小説へのコメント投稿/編集/削除

## その他

* スムーススクロール機能(jquery)

# 使用している主な技術

* Rails

* Docker(環境構築) 

* CircleCI(CI/CDパイプライン)

* CloudFront(CDN)

* Heroku(本番環境)

* Simple_form

* webpacker(Reactの導入)

* React 

* bootstrap 

* S3(表紙の画像のアップロード先)

* SendGrid(本番環境でのメール送信) 

* Rspec(テスト)

* RuboCop(コードのリファクタリング) 

* PostgreSQL(開発/テスト/本番環境のデータベース)

Dockerで環境構築しています。また、CircleCI(CI/CDパイプライン)にて自動テストをした後、Herokuへの自動デプロイを実行しています。

