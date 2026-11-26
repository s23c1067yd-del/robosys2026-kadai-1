#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yuta Sato
# SPDX-License-Identifier: BSD-3-Clause

ng () {
 echo "${1}行目のテスト失敗"
 res=1
}

res=0

### NORMAL INPUT (PIPE & SEED) ###
expected=$(python3 - << 'PYEOF'
import random
random.seed(1)
print(f'{random.choice(["ラーメン", "カレー", "うどん"])}にしよう！')
PYEOF
)
out=$(printf "ラーメン\nカレー\nうどん\n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

expected=$(python3 - << 'PYEOF'
import random
random.seed(42)
print(f'{random.choice(["ラーメン", "カレー", "うどん"])}にしよう！')
PYEOF
)
out=$(printf "ラーメン\nカレー\nうどん\n" | ./decider 42)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

expected=$(python3 - << 'PYEOF'
import random
random.seed(7)
print(f'{random.choice(["寿司", "焼肉", "パスタ", "定食"])}にしよう！')
PYEOF
)
out=$(printf "寿司\n焼肉\nパスタ\n定食\n" | ./decider 7)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(printf "ラーメン\n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "ラーメンにしよう！" ] || ng "$LINENO"

out=$(printf "\n  カレー  \n\n  そば  \n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "カレーにしよう！" ] || ng "$LINENO"

out=$(printf "ラーメン\nカレー\n" | ./decider -1)
[ "$?" = 0 ] || ng "$LINENO"
[ -n "${out}" ] || ng "$LINENO"

### INTERACTIVE MODE (PTY) ###
out_pipe=$(printf "ラーメン\nカレー\n\n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
echo "${out_pipe}" | grep -q "ラーメンにしよう！" || ng "$LINENO"

out_extra=$(printf "ラーメン\nカレー\n\nyes\nチャーシューメン\n担々麺\n\n" | ./decider 1)
[ "$?" = 0 ] || ng "$LINENO"
echo "${out_extra}" | grep -q "カレーにしよう！" || ng "$LINENO"

### STRANGE INPUT ###
out=$(printf "" | ./decider 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "\n  \n\t\n" | ./decider 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "ラーメン\nカレー\n" | ./decider abc 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "ラーメン\nカレー\n" | ./decider 1.5 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "ラーメン\nカレー\n" | ./decider 1 2 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
