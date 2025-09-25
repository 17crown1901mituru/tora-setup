#!/bin/bash

# Termuxのバッテリー最適化を無効化し、スリープを防止
termux-wake-lock

# SSHサーバーを起動
sshd

# 新しいtmuxセッションを作成し、その中でSSHトンネルを張る
# -d オプションでデタッチして、バックグラウンドで実行
tmux new-session -d -s proxy_session "ssh -D 8080 -N localhost -p 8022"

echo "SOCKS5プロキシ環境が起動しました。"
echo "新しいセッションで 'tmux attach -t proxy_session' を実行すると、SSHトンネルの状況を確認できます。"
echo "作業を開始するには、 'proxychains4 [コマンド]' を実行してください。"
