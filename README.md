# robosys2026-kadai-1

優柔不断なあなたの代わりに、お店やメニューをサクッと決めてくれるコマンド decider です。
「どこ行こう…」「何食べよう…」と迷ったら、候補を放り込んで決めてもらいましょう！

## 使い方

候補を1行ずつ入力して、空行（または Ctrl+D）で確定すると、その中からランダムに1つ選んでくれます。シード値を渡すと結果を固定することもできます。

./decider
./decider 1
printf "ラーメン\nカレー\n\n" | ./decider 1

対話モードで使うと、メニューの有無を聞かれて yes を選ぶとメニュー候補まで一緒に選んでくれます。

## テスト

./test.bash

## ライセンスと著作権

- SPDX-FileCopyrightText: 2026 Yuta Sato
- SPDX-License-Identifier: BSD-3-Clause
