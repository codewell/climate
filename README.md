# CLIMATE

Assume you wrote a super cool script in let's say bash and want other users to be able to easily install, update or remove it and use it in their terminal. That is what `climate` is for!
`climate` is a package manager for various scripts. Install `climate` and put a `.climate` file in your script root to make it easily installabale and updatable via command line.

## Table of Contents

- [CLIMATE](#climate)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [`.climate` file](#climate-file)
    - [Example](#example)
  - [Basic Usage](#basic-usage)
    - [Shebang](#shebang)

## Installation

The easiest way to install is to run this script
```
bash <(curl -s https://raw.githubusercontent.com/fippli/climate/master/easy_install)
```
and export `${HOME}/.climate/bin` to your `PATH`.

Depending on which shell you use you can run one of these scripts to permanently export `${HOME}/.climate/bin` to your `PATH`:

**bash**
```
echo "export PATH=\${HOME}/.climate/bin:\$PATH" >> ${HOME}/.bash_profile
```
**fish**
```
echo "set PATH ~/.climate/bin \$PATH" >> ~/.config/fish/config.fish
```

Then run

```
climate
```

You should get the following output:

```
CLIMATE
The minimalistic script manager

Available commands
  help                          Display this message
  init                          Interactively create .climate file
  install                       Install a script from its source
  install <git-repository-url>  Clone a script from a git repository and install
  list                          List all installed scripts
  new     <script-name>         Create a sccript boilerplate
  remove  <script-name>         Remove an installed script
  update  <script-name>         Update to the latest version of a script
                                Requires REPOSITORY field set in .climate
                                Otherwise use:
                                climate install <git-repository-url>
```

## `.climate` file

The only thing a project needs to be compatible with `climate` is the `.climate` file. Put `.climate` in the root of your project containing the following `key=value` pairs:

- `DESCRIPTION` - A short description of the script. `climate list` will display the description.

- `MAIN` - Path to the main script file relative to project root e.g. `main` or `src/somethingelse.sh`. **NOTE:**
  All files with file ending `.sh` in the same directory as the main script will be sourced.

- `NAME` - Determines the name of your script. Your program will be used like

  ```
  <script-name> <args>
  ```

  from your command line.

- `REPOSITORY` (optional) - Used for updating an installed script. Run `climate update <script-name>` to clone down the latest code from the script repository and install it.

- `VERSION` - Used to keep track of what version of a script you use. `climate list` will display the version.

### Example

```
NAME=climate
VERSION=0.1.1
MAIN=main
DESCRIPTION=Script MAnager for SHell scripts
REPOSITORY=https://github.com/fippli/climate.git
```

You can also create `.climate` interactively with `climate init` from the root directory of your project. `climate new` will create a script boilerplate including a `.climate` file.

## Basic Usage

1. Create a command line program.
2. Run `climate init` in root to create a `.climate` file.
3. Run `climate install` to install your script and make it executable.
4. Use `<script-name> <args>` to use your script.

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
   NAME=my-js-script
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
   my-js-script
   > I like the climate script since is works with JavaScript!
   ```

### Shebang
Your script is run with the `exec` command which interprets the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) of the main file. Therefore, do not forget to put the shebang in your main script file.

Language | Shebang
---------|--------
shell | #!/usr/bin/env sh
bash | #!/usr/bin/env bash
node | #!/usr/bin/env node
python 2 | #!/usr/bin/env python2
python 3 | #!/usr/bin/env python 3
