# team N

## やべぇボタン＆猫の手リストの実装

![イメージ図](https://github.com/kcg-edu-future-lab/teamN/blob/images/title.PNG?raw=true)

緊急事態の際（つまりやべぇ時）、誰かに救援を求めることがより簡単にできる仕組み、それがやべぇボタンです。

そこまでやべぇわけではない時、もしくは誰かを特定して救援を求めたい時に便利な仕組み、それが猫の手リストです。

### 事前準備 - 今の自分の状態を表明する

画面右上に見える三つのボタン、その真ん中にあるボタンが状態を設定するトグルボタンになっています。

状態は二つ。作業中か、

![作業中状態のトグルボタン](https://github.com/kcg-edu-future-lab/teamN/blob/images/work.PNG?raw=true)

ヒマ（誰かの手助けができる余裕がある）か。

![ヒマ状態のトグルボタン](https://github.com/kcg-edu-future-lab/teamN/blob/images/hima.PNG?raw=true)

今、自分はどちらの状態なのかをボタンのクリックで切り替え、表明できます。

### 緊急事態発生 - やべぇボタンを押す

緊急事態が発生しました。画面右上のやべぇボタンを押しましょう。

本当にやべぇ時に使ってもらうため、一度確認をはさむようになっています。

![やべぇボタンをほんとに押しますか？](https://github.com/kcg-edu-future-lab/teamN/blob/images/yabeeno.png?raw=true)

このまま「ほんとうにやばい」をクリックすると、

![やべぇボタン実行](https://github.com/kcg-edu-future-lab/teamN/blob/images/yabee.png?raw=true)

上のスクリーンショットの通り、その時点で「ヒマ」の状態にある人にのみ通知が送信されます。

### 誰かを特定して救援を求めたい - 猫の手リスト

「誰かに」ではなく、確実に誰かに救援を求めたい要求もあるでしょう。

その要求に答えるものが猫の手リストです。

![猫の手リスト](https://github.com/kcg-edu-future-lab/teamN/blob/images/neko.PNG?raw=true)

見ての通り、現在「ヒマ」と表明されている人の名前、電話番号（連絡先）の一覧が表示されるようになっています。

