#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   SUDO="sudo"
else
   SUDO=""
fi

if [[ $PWD == "/root" ]]; then

${SUDO} systemctl stop newt.service &&
curl -fsSL https://static.pangolin.net/get-newt.sh | bash &&
${SUDO} systemctl start newt.service

else

${SUDO} systemctl stop newt.service &&
curl -fsSL https://static.pangolin.net/get-newt.sh | bash &&
${SUDO} cp ~/.local/bin/newt /usr/local/bin/ &&
${SUDO} systemctl start newt.service

fi
