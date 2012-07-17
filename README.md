Robotlegs-vs-PureMVC-demos(AS3)
======================
[Robotlegs](http://www.robotlegs.org/) と[PureMVC](http://puremvc.org/) で同じサンプルアプリを作って比較
 
 
ダウンロード
------
* Robotlegs本体   
[http://www.robotlegs.org/](http://www.robotlegs.org/)  

* robotlegs-utilities-Modular(マルチコンテキスト対応拡張)   
[https://github.com/joelhooks/robotlegs-utilities-Modular](https://github.com/joelhooks/robotlegs-utilities-Modular)  

* ViewInterfaceMediatorMap(ViewのマッピングをInterfaceでできる拡張)   
[https://github.com/piercer/robotlegs-extensions-ViewInterfaceMediatorMap](https://github.com/piercer/robotlegs-extensions-ViewInterfaceMediatorMap)  
 


解説・チュートリアル
----------------
* Blog   
準備中
[http://www.example.com/](http://www.example.com/)  

* Slide   
準備中
[http://www.example.com/](http://www.example.com/)  

* ベストプラクティス  
[Robotlegsのドキュメント](http://d.hatena.ne.jp/hideshi_o/20111230/1325225222)  

 
サンプル
--------
* 公式サンプル集  
[https://github.com/robotlegs/robotlegs-demos-Bundle](https://github.com/robotlegs/robotlegs-demos-Bundle)   

FAQ
--------
* プリローダーSWFとメインSWFで同じコンテキストを使うには？  
[ViewInterfaceMediatorMap](https://github.com/piercer/robotlegs-extensions-ViewInterfaceMediatorMap)拡張を使いそれぞれのドキュメントクラスをInterfaceでマッピングすることで依存させないようにする。  
（参考）robotlegs.app.ApplicationContext.as  

* コンテキスト間でイベントの送受信を行うには？  
[robotlegs-utilities-Modular](https://github.com/joelhooks/robotlegs-utilities-Modular)  拡張を使う  
（参考）robotlegs.slideパッケージとrobotlegs.appパッケージで異なるコンテキストを使用し、イベントの送受信をしています。  

* １つのMediatorに複数のViewをマッピングする  
（参考）robotlegs.app.view.mediator.MainMediator.as -> setMouseListener()  
動作には問題ないがこの方法をViewInterfaceMediatorMapと併用するとDIモジュールのWarningメッセージが表示されてしまう。


* １つのコマンドで複数のイベントから実行できないか？  
できないです。複数のコマンドで１つのイベントはできます。  
（参考）[http://knowledge.robotlegs.org/discussions/questions/353-multiple-events-to-one-command-mapped-from-context-startup](http://knowledge.robotlegs.org/discussions/questions/353-multiple-events-to-one-command-mapped-from-context-startup)  

* １つのMediatorに複数のViewをマッピングする  
[https://gist.github.com/2867286](https://gist.github.com/2867286)