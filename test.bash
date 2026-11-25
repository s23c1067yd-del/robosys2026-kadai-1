#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yuta Sato
# SPDX-License-Identifier: BSD-3-Clause

expected="ラーメン にしよう！"
out=$(printf "ラーメン\nカレー\nうどん\n" | ./decider 1)
[ "${out}" = "${expected}" ] && echo OK || echo NG
