# SMASH

Assume you wrote a super cool command line interface in let's say bash and want other users to be able to easliy install it to use in their terminal. That is what `smash` is for!
`smash` is a command line interface manager for shell scripts. Install `smash` and put a `.smash` file in your cli program root to make it easily installabale and updatable via command line.

```
 •••• ••   ••  ••••   •••• ••  ••
•••   • • • • ••  •• •••   ••••••
 •••  •• • •• ••••••   ••• ••••••
••••  ••   •• ••  •• ••••  ••  ••

Script MAnager for SHell scripts

Available commands
  help                          Display this message
  init                          Create .smash file
  install                       Install a cli
  install <git-repository-url>  Clone a directory with git and install 
                                the cli
  list                          List all installed clis
  remove <cli-name>             Remove an installed cli
  update <cli-name>             Update to the latest version of a cli
                                Requires REPOSITORY field set in .smash
                                Otherwise use: 
                                smash install <git-repository-url>
```

## Installation
1. Install smash by downloading the smash source code
2. Run 
   ```bash
   bash src/main install
   ```
   from root.
3. Export `${HOME}/.smash/bin` to your path

## Basic Usage
1. Create a command line program
2. run `smash init` in root to create a `.smash` file
3. Put your source code in `/src`
5. run `smash install` to install your cli and make it executable
6. use `<cli-name> <args>` to use your cli
  
## `.smash` file

Run `smash init` to create the `.smash` file interactively

**REQUIRED FIELDS**
```
NAME=<cli-name>
```
The `NAME` field determines the name of your cli. This is how you later will use it `<cli-name> <args>` from your command line.

```
MAIN=<name-of-main-file>
```
The `MAIN` field is the name of the main script file e.g. `main.sh` or `somethingelse.sh`

```
VERSION=x.y.z
```
The `VERSION` field is to keep track of what version of a cli you use. `smash list` will display the version.

```
DESCRIPTION=<some-description>
```
Short description of the cli. `smash list` will display the description.

**OPTIONAL FIELDS**
```
REPOSITORY=<git-repository-url>
```
The `REPOSITORY` field is used for updating an installed `cli`. Run `smash update <cli-name>` to clone down the latest code from the cli repository and install it.
