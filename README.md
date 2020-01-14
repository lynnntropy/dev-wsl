# dev-wsl

This repo contains tooling that helps me setup/maintain my personal WSL 2-based development setup.

As I said above, this is my personal setup; you're absolutely free to take inspiration from it and/or steal chunks of it for your own config as much as you like, but I don't recommend using it as-is, since I don't imagine it's likely that you have the exact same name, preferred stacks, tooling preferences, etc. as me.

## Setup

The `bootstrap.sh` script is the main thing here. It takes a bare Ubuntu 18.04 installation and sets it up the way I like for my dev environment.

The script assumes you have a user named `veselin`, and expects to be run as root.

```bash
sudo ./bootstrap.sh
```

## Development

This repo also contains a `Vagrantfile` that makes it easy to quickly iterate on the script by destroying and re-instancing an Ubuntu VM (just do `vagrant destroy` and `vagrant up` anytime you want a fresh VM).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for details.
