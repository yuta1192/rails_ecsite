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


12/10

どうしてもカテゴリーのリンク先を検索した後のカテゴリー別のページにできない
→link_to、routesは合っているはず。パラメータがおかしいのかも。
コントローラは、@kinds = @products.map{|product|[product.kind]}.uniq　となっている
→これだと配列の中に配列があるので、パラメータが配列になっている。
@kinds = @products.all.pluck(:kind).uniq　に変更して見た
→できた！

payjpで購入数が多い際の文言変更
→カゴの中の商品数を在庫数に変更するように機能を変更

viewを色々いじって見やすくして見た
→まだまだ直す点が多すぎる

商品購入履歴ページ、routes作成

商品購入履歴modelとして"ProductPurchase"モデルを作成
→ここに購入した商品（カート）に入っていた情報を購入完了と同時に入れる。
→そのあとにカート内の商品を消す。


12/11

購入履歴には別にカートのIDなんていらない
カートIDと購入履歴のアソシエーション自体いらないことを気づくべきだった
購入時削除する商品情報を購入履歴に作成、その後カート内の商品を削除。
カートの中身そもそも削除するし、カートのIDから購入履歴を割り出すわけじゃないので関連性がない。
アソシエーションを考える前に機能はどんなものか考えるべき

カート一覧削除
→購入時同時に削除機能を追加

購入履歴機能
→購入時同時に購入した商品の情報をそのまま購入履歴に作成

作成時メール機能
→購入時メール機能は実装できたが、変数がアソシエーションしたものが使えないとのことでどうしようか考え中
→引数を複数渡す、とか
https://ja.stackoverflow.com/questions/22621/applicationmailer%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AB-%E9%85%8D%E5%88%97%E3%82%92%E5%BC%95%E6%95%B0%E3%81%AB%E6%B8%A1%E3%81%99%E3%81%A8serializationerror%E3%81%AB%E3%81%AA%E3%82%8B
参照

注文詳細
→ページ作成
→bootstrap使って綺麗に作るぞ！とりあえず基本的なものはamazon見つつ後はshowアクションからパラメータ引っ張ってくればおk
→routesを書いていて、たくさんネストするとその分引数が必要になってきたり読みにくくなってくる。/:idの分だけ引数が必要になるから渡す引数はその分増える。常に一つではない。


12/12

・サーチのviewをZOZOtownパクって作成
→価格バー機能、セール機能、サイズの３つ追加するものあり。

・カート機能のviewを修正
→デザイナーというカラムも商品モデルに追加
→カートでは一旦会計せず確認画面へ、購入確定確認画面から購入させる。
→confirmation.html.slim作成。ここで最終確認して購入できるようにする。
→confirmationはとりあえず購入できるまで変更した。

・お気に入りのviewを修正

・商品詳細のviewを修正
→numに追加できる個数をどうしよう、コントローラで作っちゃおう
→productコントローラに変数@numに範囲[1..product.stock]を入れる
→その後@num.to_a で配列に直せば[1,2,....,stock]となり後はviewにぶち込む

・足りない機能ブラッシュアップ
モデル・・・イベントモデル
商品モデル・・・デザイナーカラム、セールカラム、サイズカラム、セールプライスカラム
レビュー機能・・・購入した人のみその商品のコメントと評価ができる。編集も削除も可能
サーチのview・・・価格バーを追加
ユーザーモデル・・・郵便番号カラム、生年月日カラム、性別カラム、都道府県カラム

商品詳細、画像ズーム機能（虫眼鏡）
複数の関連写真を見れる（ZOZOの画像選択）
商品シェア機能
