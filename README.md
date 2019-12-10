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

12/6

・決済システム作成
→単発のシステムは完成（カゴの中にある商品の合計金額の支払い）
→ここから商品モデルに在庫（stock)を追加して購入したら在庫が減るようにしようと思ったがどうにもうまくいかず
→根本的にどのようになっているかを確認して図で描きながらやるべし、今は逃避

・タブにサイト名表示
→applicationhelperにコード書いてapplication.html.slimに追加してパパッと終了！だけど全部のページにやらなきゃだから修正しつつその都度追加の方針

・ホームをzozotownっぽくする
→cssがむずすぎる件、clearfixがよくわからなくて結構詰まってた。でもクリアフィックスするタイミングは回り込みたくないときに使えばいいんだねって
→.sampleメソッドを使用すると配列から一つランダムに取り出す　a = ["a","b","c"] a.sample => a か b か cでる


12/9

・link_toでパラメータを渡す際は第３引数くらいに(params: event.id)などのようにparamsに渡すものを入れればおk

・numericality: { only_integer: true, greater_than: 0 } numericality(数値のみが使われていることを指定するバリデーション),greater_than(指定された値よりも大きくなければならないバリデーション)

・なんとかpayjpの処理でstockを更新することに成功！cart_itemsコントローラのpayアクション中にupdate処理を書くだけだったが大きくぜんしん。ただ今の状態だとstockがマイナスになったりエラー出なかったりエラー出た場合に処理できてなかったりするから変更必要なり。

redirect_to cart_items_path(current_user)だとダメだった。
エラー文みると最後にand return　つけろとのこと。できた。

redirect_toにnotice加えればエラー文表示可能
