#!/bin/bash

# --- Termux環境の初期設定を開始します ---
echo "--- Termux環境の初期設定を開始します ---"
echo "# パッケージを最新の状態に更新"
pkg update -y
pkg upgrade -y

echo "--- 必要なパッケージをインストール ---"
echo "# 必要なパッケージをインストール"
pkg install -y git openssh proxychains-ng tmux

echo "--- SSH鍵を自動生成（パスフレーズなし） ---"
echo "# SSH鍵を自動生成および登録します ..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh # SSHディレクトリのパーミッションを設定
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa # 秘密鍵のパーミッションを設定
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys # 公開鍵のパーミッションを設定

echo "--- SSH鍵のセットアップが完了しました ---"

echo "--- GitHubリポジトリをクローン（すでにクローン済みならスキップ） ---"
if [ ! -d "tora-setup" ]; then
    echo "GitHubリポジトリをクローンします..."
    git clone https://github.com/17crown1901mituru/tora-setup.git
else
    echo "リポジトリはすでに存在します。最新の状態に更新します..."
    cd tora-setup
    git pull
    cd ..
fi

echo "--- プロキシ設定スクリプトを実行します ---"
chmod +x ./tora-setup/setup_proxychains.sh
./tora-setup/setup_proxychains.sh

echo "--- プロキシサーバーを起動します ---"
chmod +x ./tora-setup/start_proxy.sh
./tora-setup/start_proxy.sh

echo ""
echo "--- 全てのセットアップが完了しました ---"
echo "--- プロキシの動作確認 ---"
echo "プロキシ経由でIPアドレスを確認します..."
proxychains4 curl https://ifconfig.me
echo "--- 完了 ---"
