## Configure chezmoi
`$ sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply https://github.com/ahmaddynugroho/dotfiles`

## Configure interception-caps2esc

```bash
cat <<\EOF | sudo tee /etc/interception/udevmon.d/caps2esc.yaml
- JOB: intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF
sudo systemctl enable udevmon```
