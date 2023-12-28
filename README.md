# ReScript with nix
**Status**: Works on simple example

> [!IMPORTANT]
> no JS runtime is involved or harmed in any way in this experiment

![meme](https://i.imgflip.com/8aq6ik.jpg)

## Usage
```sh
nix develop github:DrSensor/rescript.nix
```

## Dev

Clone the repo first <sub>(don't do human cloning because the code written here is not designed for that)</sub>
```sh
git clone https://github.com/DrSensor/rescript.nix.git
cd rescript.nix/
```

Activate nix devshell (you can also use `nix develop`)
```sh
direnv allow
```

Let's test out by compiling the simple example
```sh
cd examples/simple/
rescript
```
