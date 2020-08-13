# SMASH

```
   •••• ••   ••  ••••   •••• ••  ••
  •••   • • • • ••  •• •••   ••  ••
    ••• •• • •• ••••••   ••• ••••••
  ••••  ••   •• ••  •• ••••  ••  ••
```


**S**cript **MA**nager for **SH**ell

## Basic Usage
Assume you wrote a super cool command line interface in bash and want other users to be able to easliy install it to use in their terminal. That is what smash is for! Put a `.smash` file in the root directory of your program:
```bash
NAME=your_cli
```
Use `smash` to install the cli from its root directory (where `.smash` shold be)
```bash
smash install
```
to install the cli as `your_cli` to later use it as
```bash
your_cli <args>
```

Whenever you want to uninstall the cli just simply use
```bash
smash uninstall
```
from the root of the same project.

## Installation
Install smash by downloading the smash source code and run
```bash
bash src/main
```
from root.

Export `~/.smash/bin` to your path by adding
```bash
export PATH="$HOME/.smash/bin:$PATH"
```
to `~/.bash_profile`

## CLI Structure
If you want to create your own cli and make it installable with `smash` there are two requirements:
1. All the code for the cli should be located in a directory called `src` in the project root.
2. The root of the project should contain a file `.smash` containing 
  ```
  NAME=<cli-name>
  MAIN=<name-of-main-file>
  ```
  run `smash init` to create interactively.
