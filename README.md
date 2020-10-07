# SMASH

Assume you wrote a super cool command line interface in let's say bash and want other users to be able to easliy install, update or remove it and use it in their terminal. That is what `smash` is for!
`smash` is a command line interface manager for shell scripts. Install `smash` and put a `.smash` file in your cli program root to make it easily installabale and updatable via command line.

## Table of Contents

- [SMASH](#smash)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [`.smash` file](#smash-file)
    - [Example](#example)
  - [Basic Usage](#basic-usage)
    - [EXAMPLE](#example-1)
  - [Tutorials](#tutorials)

## Installation

Export `${HOME}/.smash/bin` to your path and run the following commands

```
git clone https://github.com/fippli/smash.git
cd smash
bash main install
```

or run this convenience script if you dare

```
bash <(curl -s https://raw.githubusercontent.com/fippli/smash/master/easy_install)
```

Then run

```
smash
```

You should get the following output:

```
 •••• ••   ••  ••••   •••• ••  ••
•••   • • • • ••  •• •••   ••••••
  ••• •• • •• ••••••   ••• ••••••
••••  ••   •• ••  •• ••••  ••  ••

Script MAnager for SHell scripts

Available commands
  help                          Display this message
  init                          Interactively create .smash file
  install                       Install a cli
  install <git-repository-url>  Clone a cli from git and install
  list                          List all installed clis
  new                           Create a cli boilerplate
  remove <cli-name>             Remove an installed cli
  update <cli-name>             Update to the latest version of a cli
                                Requires REPOSITORY field set in .smash
                                Otherwise use:
                                smash install <git-repository-url>
```

## `.smash` file

The only thing a project needs to be compatible with `smash` is the `.smash` file. Put `.smash` in the root of your project containing the following `key=value` pairs:

- `COMMAND` What command to start your main file with e.g. `python3` for your `main.py` or `bash` for your `main.sh`.

- `DESCRIPTION` - A short description of the cli. `smash list` will display the description.

- `MAIN` - Path to the main script file relative to project root e.g. `main` or `src/somethingelse.sh`. **NOTE:**
  All files with file ending `.sh` in the same directory as the main script will be sourced.

- `NAME` - Determines the name of your cli. Your program will be used like

  ```
  <cli-name> <args>
  ```

  from your command line.

- `REPOSITORY` (optional) - Used for updating an installed `cli`. Run `smash update <cli-name>` to clone down the latest code from the cli repository and install it.

- `VERSION` - Used to keep track of what version of a cli you use. `smash list` will display the version.

### Example

```
NAME=smash
VERSION=0.1.1
MAIN=main
DESCRIPTION=Script MAnager for SHell scripts
REPOSITORY=https://github.com/fippli/smash.git
COMMAND=bash
```

You can also create `.smash` interactively with `smash init` form the root directory of your project. `smash new` will create a cli boilerplate including a `.smash` file.

## Basic Usage

1. Create a command line program.
2. Run `smash init` in root to create a `.smash` file.
3. Run `smash install` to install your cli and make it executable.
4. Use `<cli-name> <args>` to use your cli.

### EXAMPLE

```
smash new <cli-name>
cd <cli-name>
smash install
<cli-name> foo --bar hello world
```

## [Tutorials](https://github.com/fippli/smash/wiki#tutorials)

See the [wiki page for tutorials](https://github.com/fippli/smash/wiki#tutorials)
