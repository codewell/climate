# CLIMATE

Assume you wrote a super cool command line interface in let's say bash and want other users to be able to easliy install, update or remove it and use it in their terminal. That is what `climate` is for!
`climate` is a command line interface manager for shell scripts. Install `climate` and put a `.climate` file in your cli program root to make it easily installabale and updatable via command line.

## Table of Contents

- [CLIMATE](#climate)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [`.climate` file](#climate-file)
    - [Example](#example)
  - [Basic Usage](#basic-usage)
    - [EXAMPLE](#example-1)
  - [Tutorials](#tutorials)

## Installation

Export `${HOME}/.climate/bin` to your path and run the following commands

```
git clone https://github.com/fippli/climate.git
cd climate
bash main install
```

or run this convenience script if you dare

```
bash <(curl -s https://raw.githubusercontent.com/fippli/climate/master/easy_install)
```

Then run

```
climate
```

You should get the following output:

```
CLIMATE
The friendly command line interface manager

Available commands
  help                          Display this message
  init                          Interactively create .climate file
  install                       Install a cli
  install <git-repository-url>  Clone a cli from git and install
  list                          List all installed clis
  new     <cli-name>            Create a cli boilerplate
  remove  <cli-name>            Remove an installed cli
  update  <cli-name>            Update to the latest version of a cli
                                Requires REPOSITORY field set in .climate
                                Otherwise use:
                                climate install <git-repository-url>
```

## `.climate` file

The only thing a project needs to be compatible with `climate` is the `.climate` file. Put `.climate` in the root of your project containing the following `key=value` pairs:

- `COMMAND` What command to start your main file with e.g. `python3` for your `main.py` or `bash` for your `main.sh`.

- `DESCRIPTION` - A short description of the cli. `climate list` will display the description.

- `MAIN` - Path to the main script file relative to project root e.g. `main` or `src/somethingelse.sh`. **NOTE:**
  All files with file ending `.sh` in the same directory as the main script will be sourced.

- `NAME` - Determines the name of your cli. Your program will be used like

  ```
  <cli-name> <args>
  ```

  from your command line.

- `REPOSITORY` (optional) - Used for updating an installed `cli`. Run `climate update <cli-name>` to clone down the latest code from the cli repository and install it.

- `VERSION` - Used to keep track of what version of a cli you use. `climate list` will display the version.

### Example

```
NAME=climate
VERSION=0.1.1
MAIN=main
DESCRIPTION=Script MAnager for SHell scripts
REPOSITORY=https://github.com/fippli/climate.git
COMMAND=bash
```

You can also create `.climate` interactively with `climate init` form the root directory of your project. `climate new` will create a cli boilerplate including a `.climate` file.

## Basic Usage

1. Create a command line program.
2. Run `climate init` in root to create a `.climate` file.
3. Run `climate install` to install your cli and make it executable.
4. Use `<cli-name> <args>` to use your cli.

### EXAMPLE

```
climate new <cli-name>
cd <cli-name>
climate install
<cli-name> foo --bar hello world
```

## [Tutorials](https://github.com/fippli/climate/wiki#tutorials)

See the [wiki page for tutorials](https://github.com/fippli/climate/wiki#tutorials)
