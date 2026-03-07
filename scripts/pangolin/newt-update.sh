#!/usr/bin/env bash

sudo systemctl stop newt.service && curl -fsSL https://static.pangolin.net/get-newt.sh | bash && sudo cp .local/bin/newt /usr/local/bin/ && sudo systemctl start newt.service
