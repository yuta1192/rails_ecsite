# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

今回の反省点
・要件定義、詳細設計をしっかりと作るべきだった。
・後々必要なものを追加するのではなく一画面にどのような機能を入れればいいのかを事前に考えればここまでぐちゃぐちゃにならなかったかも。
・あとは開発の遅さがダメだった、やるときはパパッと作らないと何していたか忘れる。
・githubも全然使っていなかった、現場で習った方法で一つの実装ごとにgitを活用できるようにして行く。
・まだまだ開発段階のテストなので細部まできちっと仕上げる
・無理にjsを使おうとせずに、まずはできる範囲でやっていき、学んでからまた新しくjsやruby,railsを使ってサイトを作る。



12/4

・uniqをすると重複している値をまとめることができる

・ActionView::Template::Error (undefined method 'rel' for #<Kaminari::Helpers::Paginator::PageProxy:0x00007fc42e96bd98>):errorが出てくる
kaminariのテンプレート使おうとしてエラー
→kaminariのバージョン古かっただけ

12/5

・ソート機能の追加
→https://qiita.com/tsubasa_upset/items/f53fb71bda5b18be949f　見ながら自分のに照らし合わせて作成
→ダメだった
→サーチは無理やり昇順ボタンを作成して切り替えられるように変更

・ソート機能追加やり方変更
→https://qiita.com/DURIAN_JADE/items/61fd692f04600a6cf9ff
→helperを使うときはちゃんとincludeしましょう。helperはモジュールです。
→一つできればあとはカラムを変更して使うだけで使用可能！

・メーラー機能追加
→メーラー機能作成完了。
→しかし、payがまだまだ未完成だったのでこちらの修正も忘れないように

・エクスポート機能
→まずはadminがuser一覧をエクスポートできるようにする。
→難なくクリア
