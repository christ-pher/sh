#!/usr/bin/env bash

read -p "Url: " endpoint
read -p "ID: " id
read -p "Secret: " secret

sudo mkdir -p /user/local/bin &&
curl -fsSL https://static.pangolin.net/get-newt.sh | bash && 
sudo cp ~/.local/bin/newt /usr/local/bin/ &&

sudo tee /etc/systemd/system/newt.service > /dev/null <<EOF
[Unit]
Description=Newt
After=network.target

[Service]
ExecStart=/usr/local/bin/newt --id $id --secret $secret --endpoint $endpoint
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload &&
sudo systemctl start newt.service &&
sudo systemctl enable newt.service
