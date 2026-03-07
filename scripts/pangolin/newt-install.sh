#!/usr/bin/env bash

read -p "Url: " endpoint
read -p "ID: " id
read -p "Secret: " secret

if [[ $EUID -ne 0 ]]; then
   SUDO="sudo"
else
   SUDO=""
fi

${SUDO} mkdir -p /user/local/bin &&
curl -fsSL https://static.pangolin.net/get-newt.sh | bash && 
${SUDO} cp ~/.local/bin/newt /usr/local/bin/ &&

${SUDO} tee /etc/systemd/system/newt.service > /dev/null <<EOF
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

${SUDO} systemctl daemon-reload &&
${SUDO} systemctl start newt.service &&
${SUDO} systemctl enable newt.service
