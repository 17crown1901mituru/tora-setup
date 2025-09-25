#!/bin/bash

echo "--- Termux 環境の初期設定を開始します ---"

# パッケージを最新の状態に更新
pkg update -y
pkg upgrade -y

# 必要なパッケージをインストール
pkg install -y git openssh proxychains-ng tmux

echo "--- パッケージのインストールが完了しました ---"

# SSH鍵を自動生成（パスフレーズなし）
echo "--- SSH鍵を自動生成および登録します ---"
mkdir -p ~/.ssh
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "--- SSH鍵のセットアップが完了しました ---"

# GitHubリポジトリをクローン（すでにクローン済みならスキップ）
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

# setup_proxychains.shに実行権限を付与し、実行
chmod +x ./tora-setup/setup_proxychains.sh
./tora-setup/setup_proxychains.sh

echo "--- プロキシサーバーを起動します ---"

# start_proxy.shに実行権限を付与し、実行
chmod +x ./tora-setup/start_proxy.sh
./tora-setup/start_proxy.sh

echo "--- 全てのセットアップが完了しました ---"

echo ""
echo "--- プロキシの動作確認 ---"
echo "プロキシ経由でIPアドレスを確認します..."
proxychains4 curl https://ifconfig.me
echo "--- 完了 ---"
