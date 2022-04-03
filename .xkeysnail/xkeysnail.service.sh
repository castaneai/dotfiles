cat <<EOS
[Unit]
Description=xkeysnail

[Service]
Type=simple
KillMode=process
ExecStartPre=$(which xhost) +SI:localuser:root
ExecStart=$(which xkeysnail) ${HOME}/.xkeysnail/config.py -q
Restart=on-failure
RestartSec=3
Environment=DISPLAY=${DISPLAY}

[Install]
WantedBy=default.target
EOS
