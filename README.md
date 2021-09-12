# アプリケーション名

　「My本棚」

# アプリケーション概要

　「My本棚」は追加したい本のタイトルを検索して、自分だけの本棚を作成するアプリケーションです。  
書店で本を購入する時に「この本何巻まで持ってたかな？」というちょっとした悩みを解消したくて制作することにしました。


# 開発環境

- Xcode 12.5.1
- Swift 5.4.2
- CocoaPods 1.10.1
- Alamofire 5.4.3
- Realm 10.12.0
- RealmSwift 10.12.0
- SDWebImage 5.11.1
- SwiftyJSON 5.0.1

<!-- # 注意事項

　Xcodeにてシミュレーターを用いてテストする際は、ターミナルで`pod install`コマンドを入力しライブラリのインストールを行ってください。  
 ※Podsフォルダの容量が大きいので、GitHub管理下から除外しています。 -->
 
> Xcodeにてシミュレーターを用いてテストする際は、ターミナルで`pod install`コマンドを入力しライブラリのインストールを行ってください。Podsフォルダの容量が大きいので、GitHub管理下から除外しています。

#  動作デモ

<div align="center">
    <img src="https://dl.dropboxusercontent.com/sh/htzlat3vjy5em11/AADEl6eacaznMCbogOwK8v6za/gif/bookAdd.gif" alt="bookAdd" title="本を追加" width="400" height="500">
</div>
　　
<div align="center">
    追加したい本のタイトルを検索してMy本棚に保存できます。
</div>

<br><br>
<div align="center">
    <img src="https://dl.dropboxusercontent.com/sh/htzlat3vjy5em11/AAAZsLKsCC5bB8N1VJNPSwD8a/gif/bookDetail.gif" alt="bookDetail" title="本の詳細" width="400" height="500">
</div>
　　
<div align="center">
    保存した本をタップすると、本のイメージ、タイトル、著者、出版社、発売日データを確認できます。
</div>

<br><br>
<div align="center">
    <img src="https://dl.dropboxusercontent.com/sh/htzlat3vjy5em11/AAD-N8uwBshFgkcMT9CVUQXua/gif/bookDelete.gif" alt="bookDelete" title="本を削除" width="400" height="500">
</div>
　　
<div align="center">
    My本棚から登録した本を削除することもできます。
</div>

<br><br>
<div align="center">
    <img src="https://dl.dropboxusercontent.com/sh/htzlat3vjy5em11/AABNGpjG1dBUhqHu83P-43Xga/gif/bookSave.gif" alt="bookSave" title="データは消えない" width="400" height="500">
</div>
　　
<div align="center">
    アプリを閉じてもMy本棚に保存されたデータは消えません。  
</div>

# 各動作の詳細説明

- __本の追加__
  1. 「My本棚」画面で「＋」ボタンをタップ

  1. `UISearchBar`に検索したい本のタイトルを入力し検索

  1. 「楽天ブックス書籍検索API」を用いて取得した情報をUITableViewに表示

  1. 「My本棚」に追加したい本の`cell`をタップすると、`File Manager`でiOS内に本のイメージ保存用の宛先URLを生成後に保存し、生成したイメージ保存用の宛先URL、タイトル、著者、出版社、発売日データを`Realm`に保存

  1. 「My本棚」に画面遷移


- __本の詳細__
  1. 「My本棚」画面では`Realm`に保存されている情報を取得し`UITableView`に表示

  1. 詳細を確認したい本の`cell`をタップすると詳細情報画面に遷移、その際にタップした`cell`の`indexpath.row`を詳細情報画面に渡す

  1. 渡された`indexpath.row`に対応した`Realm`に保存されているデータを取得し表示


- __本の削除__
  1. 詳細情報画面右上の「ゴミ箱」ボタンをタップ

  1. 「この本をMy本棚から削除しますか?」というアラートを表示させ、「削除」をタップすると`File Manager`でiOS内に保存されている本のイメージURLにアクセスし削除、その後`Realm`にアクセスし、イメージ保存用の宛先URL、タイトル、著者、出版社、発売日データを削除

# 今後改善していきたいこと

- ~~本の検索結果画面で追加読み込みする際の動作が重たいためロード画面を追加する、もしくは一番下の`cell`到達前からデータ読み込みを開始する。~~ → R3.9.12 一番下の`cell`到達前からデータ読み込みを開始する様に変更。

- タイトル検索に加えてバーコード検索や著者検索機能を実装する。

- ~~本の追加時にまとめて選択できる機能を追加する。~~ → R3.9.13 設定画面を追加し、一冊ずつ追加かまとめて追加するか設定できるよう変更。

# 最後に

- Swiftは2021年6月からUdemyや書籍等で独学を開始しました。

- 本アプリの制作には2週間程度費やしました。

- 学生時代にCやPyhtonを多少経験していたので、制御構文などは理解しやすいことが多かったです。しかしデータベースの使用方法や、APIなどわからないことの方が多く、 __"とにかく調べてやってみる"__ を意識し、試行錯誤を重ね無事制作する事ができました。

- 最終的にはApp Storeでリリースできるようチャレンジしていきます。
