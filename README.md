# BtoC向けECサイト

## 要件定義

* 20代男性向けファッションサイト

* 1つのショップが運営している個人EC

* BtoC

### フロント側機能

* 顧客機能
- [x] ログインページ
- [x] 新規登録ページ
- [x] パスワード再発行
  - メールアドレスを入力
  - メールアドレス宛に再発行url発送
  - urlからパスワードを変更
- [x] 会員情報確認
- [x] 会員情報修正
- [x] 注文一覧表示（カート機能）
- [x] 注文履歴
- [x] お気に入り
- [x] 退会
  - 退会リンク
  - 注意文などを記載
  - はいを押すと退会
  - user情報と関連する情報全てを削除させる

* トップページ
- [ ] おすすめ一覧
  - 売れ筋商品を載せる
  - 購入された順
- [ ] 新着一覧
  - 新着順に表示
- [ ] セール、イベント情報
  - セール情報
  - イベント情報
- [x] 人気、ランキング
- [x] 商品カテゴリー

* 共通メニュー
- [x] ヘッダー（ログイン前）
- [x] フッター(ログイン前)
- [x] ヘッダー（ログイン後）
- [x] フッター(ログイン後)
- [ ] ヘッダー（管理者）
  - イベント、セール欄
  - 在庫一覧
  - 受注、出荷
  - メルマガ
  - レビュー
- [x] フッター(管理者)

* 商品一覧
- [x] カテゴリー別検索
- [ ] 並び替え
  - ボタンを押すと並び替えする
- [ ] 表示方法変更
  - 名前のみ、画像を大きめなど
- [ ] 一覧からカート
  - 一覧からカートに入れられるボタン作成
- [x] 一覧からお気に入り

* 商品詳細
- [x] 商品詳細情報
- [x] 在庫切れ情報
- [x] お気に入り機能
- [x] 注文機能
- [ ] レビュー機能
  - レビューをされ、申請が通ったものを表示させる
- [x] 関連商品

* 注文（購入確定前)※要ログイン
- [x] カート内情報
- [x] 確定画面移行リンク
- [ ] おすすめ一覧
  - おすすめ一覧を右欄に出す

* 注文（購入確定）※要ログイン
- [x] 注文情報
- [ ] 決済方法
  - 現金なのか、PAYJPなのか
- [ ] 配達指定
  - 配達の指定
- [x] 確認画面
- [x] 在庫再チェック

* 注文完了処理 ※要ログイン
- [x] 注文番号
- [ ] メール自動送信
  - 購入完了時に自動で購入者にメールを送る

### 管理側

* ログイン機能
- [x] ログイン機能
- [ ] 管理者登録機能
  - 管理者も作成できるようになる
- [ ] パスワード変更機能
  - フロント画面と同様

* サマリー機能
- [ ] 入金、出荷などの処理状況チェック
  - 入金未確認件数
  - 未出荷件数
  - リンクから詳細に飛ぶ
- [ ] 受注状況チェック
  - 昨日、今日、今週、今月の受注件数、受注額表示
- [ ] 発注状況チェック
  - 受注件数、処理状況
- [ ] 商品状態
  - 登録数、公開数、品切れ数などを表示
- [ ] 売れ筋商品
  - 売れている商品の個数、受注件数を表示

* 商品管理
- [x] 新規登録、編集
- [x] 一覧、検索
- [ ] 商品情報CSV機能
  - アップロード
  - 印刷用のダウンロード
- [ ] 商品一括変更機能
  - 選択した商品を一括で編集
- [ ] 公開、非公開機能
  - 旬のものを売る場合
- [ ] 公開、非公開機能や、季節限定のものを公開、非公開

* 在庫管理
- [ ] 在庫の変動確認
  - 商品がどれだけ在庫が変化したかを見れる
- [ ] 一括追加
  - CSVで一括
  - 選択したものを一括で選択した個数在庫を追加
- [ ] 管理者に品切れメール
  - 在庫切れをした場合メールを管理者に送る
- [ ] 在庫なしのみ発注機能
  - 在庫なしのみ一括で発注

* 受注管理(出荷前の物を編集やキャンセルなどできる)
- [x] 受注内容変更
  - キャンセルx
  - 個数を減らすx
  - 住所を変えるx
    - ユーザーに住所address1,address2,zip_codeのカラム追加（1は都道府県。セレクトで選択できる。2は自分で打ち込むstring、zip_codeは数値7桁)
    - productpurchaseにshippingaddressを加えることでユーザーの住所自体を変更せずに宛先だけ変更できる。
  - 宅配日時変えるなどx
- [x] 納品書発行
  - 納品書を作成する
- [x] 詳細、一覧
  - 受注内容の詳細、一覧を作るx
- [x] 終了
  - 既に受注処理が終わっている一覧、詳細(出荷に移す)
- [x] 受注状況CSV
  - 印刷用ダウンロード
  - インポート
- [x] order_idで検索できる

* 出荷管理
- [x] 出荷一覧、詳細
  - 出荷したものの一覧や詳細
  - 検索
- [x] 出荷状況確認
  - 出荷可能、着手、出荷済などのステータス管理
  - ステータス毎にソート
- [x] 出荷状況CSV
  - 印刷用ダウンロード
  - インポート
- [ ] トータルピッキングリスト
  - 商品ごとに出荷数量を集計して印刷用のファイル作成
   - 合計購入個数
   - エクスポート
   - 商品検索、ソート
- [x] 納品書、請求書
  - 納品書、請求書の作成
- [x] order_idで検索できる

* メルマガ機能
- [ ] 作成
  - 作成画面
- [ ] 履歴
  - 今まで送ったメルマガの履歴
- [ ] メルマガ会員一覧
  - 現在の会員数など
- [ ] 会員登録
  - 一般ユーザが会員登録できる
- [ ] 会員削除
  - 一般ユーザが会員退会できる
  - 管理者が削除できる

* 会員管理
- [x] 一覧、検索
- [x] 登録、編集
- [ ] 会員情報CSV
  - 会員情報を印刷用ダウンロード
  - インポート

* お問い合わせ
- [ ] 一覧
  - お客さんからきた問い合わせ一覧
- [ ] 詳細
  - 一覧から詳細
- [ ] 返信
  - 詳細からユーザーのメールアドレスに向けて返信

* レビュー管理
- [ ] 一覧、詳細
  - レビューの一覧
  - レビューの詳細
- [ ] 削除、編集
  - 不適切なレビュー削除
  - 不適切な部分を編集
- [ ] 承認
  管理者がレビューを確認し。承認を押したら見れるようになる

* セール、イベント
- [ ] 削除、編集
  - セール、イベントの削除、編集
- [ ] 一覧、詳細
  - セール、イベントの一覧
  - セール、イベントの詳細
- [ ] 新規登録
  - セール、イベントの新規登録




今回の反省点
・要件定義、詳細設計をしっかりと作るべきだった。
・後々必要なものを追加するのではなく一画面にどのような機能を入れればいいのかを事前に考えればここまでぐちゃぐちゃにならなかったかも。
・あとは開発の遅さがダメだった、やるときはパパッと作らないと何していたか忘れる。
・githubも全然使っていなかった、現場で習った方法で一つの実装ごとにgitを活用できるようにして行く。
・まだまだ開発段階のテストなので細部まできちっと仕上げる
・無理にjsを使おうとせずに、まずはできる範囲でやっていき、学んでからまた新しくjsやruby,railsを使ってサイトを作る。
・ユーザー（使用者）を第一に考えながら作成する。
・作成する順番も考えながら作る。


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
商品モデル・・・デザイナーカラム、セールカラム、サイズカラム、セールプライスカラム、カルーセル機能追加
レビュー機能・・・購入した人のみその商品のコメントと評価ができる。編集も削除も可能
サーチのview・・・価格バーを追加
ユーザーモデル・・・郵便番号カラム、生年月日カラム、性別カラム、都道府県カラム

商品詳細、画像ズーム機能（虫眼鏡）
複数の関連写真を見れる（ZOZOの画像選択）
商品シェア機能

12/13

最近は手を広げすぎて一つ一つの質が落ちてると指摘。一つの機能をしっかりと終わらせていく。

商品モデルにカラムを（デザイナー、セールフラグ、サイズ）追加

・ホームにデザイナー一覧追加

・searchでデザイナー、セール、サイズで検索可能に
→selectにcssが適応しない？なぜ？
→https://qiita.com/nakanoyoshiki/items/e87a6238f8febbeb208a

・fieldの中にあるグレーの文字のことをなんていうんだっけ？
→placeholderだったわ

sort機能を理解しながら作ってみる。

12/18

order_idの取得方法をdescriptionにuser_idを入れ一致した場合@order_idに課金IDを入れてbreakしてループから抜け出す。

form_withの使い方、form全般がよくわかっていないかもしれない。一旦使い方をしっかりと理解してから進もう。
使用例（https://github.com/rails/rails/blob/7252c2133f6f44085c64b1876cf41902e6a73847/actionview/lib/action_view/helpers/form_helper.rb#L483-L738）

配達の日にち、配達時間の範囲カラムをProductPurchaseとCartItemに追加


12/20

可読性を上げるよう。ただ動くだけ、ではなくこだわりを持って他の人がみたときにすぐにわかるようなコードを書くように心がけよう。
例えばモデルでメソッド作ってあげるとか。コントローラーに書きなぐりすぎるとif文がネストしまくって読みにくかったりする。

viewの部分であとで変更しようと後回しにしているものは必ずチェックしておこう。
やり忘れたままになってしまうことも多くなってしまうため。

csvのインポート（https://qiita.com/seitarooodayo/items/c9d6955a12ca0b1fd1d4）
