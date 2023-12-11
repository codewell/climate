#!/usr/bin/env bash

create () {
  name="${2}"
  version='0.1.0'
  main='main'
  description="${3:-"Script created with \"climate create\""}"

  mkdir "$(pwd)/${name}"
  touch "$(pwd)/${name}/.climate"

  main_path="$(pwd)/${name}/${main}"
  touch "${main_path}"
  chmod +x "${main_path}"


  echo "#!/usr/bin/env bash" > "${main_path}"
  echo "set -o errexit -o pipefail -o nounset" >> "${main_path}"
  echo "# ${name} - v${version}" >> "${main_path}"
  echo "echo 'hello, world! from' ${name}" >> "${main_path}"

  
  { echo "NAME=${name}";
    echo "VERSION=${version}";
    echo "DESCRIPTION=${description}"; 
    echo "REPOSITORY=";
    echo "MAIN=${main}";
    } > "$(pwd)/${name}/.climate"

  echo "> Run \"climate install\" in script root to install the script"
}

