#!/bin/bash

# Baron FM Radio - Otomatik Yayın Kurulumu

echo "Gerekli paketler kuruluyor..."
apt update && apt install -y icecast2 ezstream

echo "icecast2 servisi başlatılıyor..."
systemctl enable icecast2
systemctl start icecast2

echo "Yayın yapılandırması için örnek ezstream.xml oluşturuluyor..."
mkdir -p /root/radio
cat <<EOF > /root/radio/ezstream.xml
<ezstream>
  <url>http://localhost:8000/live</url>
  <sourcepassword>hackme</sourcepassword>
  <format>MP3</format>
  <filename>/root/radio/playlist.m3u</filename>
  <stream_once>0</stream_once>
</ezstream>
EOF

echo "Örnek çalma listesi (playlist.m3u) oluşturuluyor..."
cat <<EOF > /root/radio/playlist.m3u
/root/radio/sample.mp3
EOF

echo "Kurulum tamamlandı. Yayın başlatmak için:"
echo "ezstream -c /root/radio/ezstream.xml"
