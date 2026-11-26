# robosys2026-kadai-1

入力された候補の中からランダムに1つ選ぶコマンド decider です。お店やメニューなどの候補を決めたいときに使用できます。

## 動作環境

- OS: Linux (`ubuntu-latest` にて動作確認)
- Python: 3.x

## 使い方

候補を1行ずつ標準入力から渡し、空行または EOF (`Ctrl+D`) で入力を終えると、候補の中から1つ選択します。引数にシード値（整数）を指定すると、選択結果を固定できます。

    $ ./decider
    $./decider 1$ printf "ラーメン\nカレー\n\n" | ./decider 1

端末（対話モード）から実行した場合は、メニューの有無を確認され、`yes` を入力するとメニュー候補も追加で選択できます。

## テスト

    $ ./test.bash

## ライセンス

- SPDX-FileCopyrightText: 2026 Yuta Sato
- SPDX-License-Identifier: BSD-3-Clause
