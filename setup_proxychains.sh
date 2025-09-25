#!/bin/bash

echo "proxychains-ngの設定ファイルを編集します..."

# 設定ファイルをバックアップ
cp /data/data/com.termux/files/usr/etc/proxychains.conf /data/data/com.termux/files/usr/etc/proxychains.conf.bak

# 設定ファイルを編集
sed -i 's/strict_chain/dynamic_chain/' /data/data/com.termux/files/usr/etc/proxychains.conf
sed -i 's/#dynamic_chain/dynamic_chain/' /data/data/com.termux/files/usr/etc/proxychains.conf
sed -i 's/socks4/#socks4/' /data/data/com.termux/files/usr/etc/proxychains.conf

# プロキシ情報を追加
echo "" >> /data/data/com.termux/files/usr/etc/proxychains.conf
echo "# --- Custom Proxy Settings ---" >> /data/data/com.termux/files/usr/etc/proxychains.conf
echo "socks5 127.0.0.1 8080" >> /data/data/com.termux/files/usr/etc/proxychains.conf

echo "proxychains-ngの設定が完了しました。"
echo "元のファイルはproxychains.conf.bakとして保存されています。"

