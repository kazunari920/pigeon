# Pigeon 概要
URL : [https://pigeon-400z.onrender.com/](https://pigeon-400z.onrender.com/)

このアプリケーションは、利用者が好みに合ったフォトグラファーを見つけたり、依頼を申し込んだり、コミュニケーションを取ることができる機能を持っています。

# 開発動機
フォトグラファーに写真を撮ってもらうという機会は、一般的にあまり多くありません。

大多数の人がはじめてフォトグラファーに依頼を申し込むのは結婚式の際だと思います。

ですが結婚式を行う場所によって、当日までフォトグラファーと連絡を取ることがない、どのような人物が来るのか分からないという事も少なくありません。

自分が探す場合でも、誰かに用意してもらった場合でも、名前さえ知っていればその人がどんな人でどのような写真を撮るのか見ることができる。

また本人と直接コミュニケーションを取ったり、その人を気に入った場合継続して依頼を申し込むことができる。

そのようなサービスがあったらいいな、と思い開発を始めました。

# 実装機能
- ユーザー管理機能
  - deviseを使用したユーザー管理機能

- 名前とタグによるフォトグラファー検索機能
  - 設定されている名前とacts-as-taggable-onを使用したタグによる検索機能

- フォトグラファーによる画像アップロードと利用者による閲覧
  - AWS S3を利用したアップロード機能

- 利用者の気に入ったフォトグラファーへのいいね機能
  - アカウントに対するいいね機能

- 利用者による依頼申し込み機能と依頼の進行度に合わせたステータス管理
  - 依頼を承諾か拒否ができ、完了したさいにcompleteにすることができる

- 利用者とフォトグラファー間のダイレクトメッセージ機能
  - ステータスが承諾になったあとにダイレクトメッセージを開始できる

# 実装予定の機能
- レビュー機能
  - フォトグラファーが依頼を完了させた際、利用者がレビューを投稿できる

- コメント機能
  - 利用者がフォトグラファーに対してコメントをすることができる

- お気に入り機能
  - 利用者が気に入ったフォトグラファーをお気に入りに追加して管理することができる

- ブロック機能
  - フォトグラファーが一部利用者を依頼が送れないようブロックすることができる


#　修正予定
- requestモデルの各メソッドを見直し（詳細はコメント)
  - enumの使用と不必要なメソッドの削除

# 使用技術
Ruby, Ruby on Rails, AWS(S3 RDS), Docker

