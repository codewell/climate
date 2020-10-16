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
  - [Tutorial](#tutorial)
    - [Shebang](#shebang)

## Installation

Export `${HOME}/.climate/bin` to your path and run the following commands

**bash**
```
echo "export PATH=\${HOME}/.climate/bin:\$PATH" >> ${HOME}/.bash_profile
```
**fish**
```
echo "set  PATH ~/.climate/bin \$PATH" >> ~/.config/fish/config.fish
```

Then get the source and run the install script
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

## Tutorial
1. Create a directory where you will put all your code and navigate to it e.g.
   ```
   mkdir my-code && cd my-code
   ```

2. Create a script you wish to run from your terminal in let's say JavaScript. Put your code in a file `index.js` containing:
   ```JavaScript
   #!/usr/bin/env node
   console.log("I like the climate script since is works with JavaScript!");
   ```

3. Make your script executable with
   ```
   chmod +x index.js
   ```

4. Run `climate init` to create a .climate file:
   ```
   NAME=my-js-cli
   MAIN=index.js
   DESCRIPTION=My cool js script
   VERSION=0.0.1
   REPOSITORY=
   ```

5. Run 
   ```
   climate install
   ```

6. Run your script like 
   ```
   my-js-cli
   > I like the climate script since is works with JavaScript!
   ```

### Shebang
Your script is run with the `exec` command which interprets the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) of the main file. Therefore, do not forget to put the shebang in your main script file.
