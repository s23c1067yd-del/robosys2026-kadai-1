#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yuta Sato
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目のテスト失敗"
    res=1
}

res=0

### NORMAL INPUT ###
expected=$(python3 -c 'import random; random.seed(1); print(random.choice(["ラーメン", "カレー", "うどん"]) + " にしよう！")')
out=$(printf "ラーメン\nカレー\nうどん\n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(printf "" | ./decider 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "ラーメン\nカレー\n" | ./decider abc 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
