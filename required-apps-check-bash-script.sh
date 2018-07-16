#!/bin/bash

# array of programs to check
declare -a programs=(
  "git "
  "node" 
  "code"
  "brew"
  "mysql"
  "heroku"
)

# Functions ==============================================

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# return 1 if local npm package is installed at ./node_modules, else 0
# example
# echo "gruntacular : $(npm_package_is_installed gruntacular)"
function npm_package_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  ls node_modules | grep $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}


# display a message in red with a cross by it
# example
# echo echo_fail "No"
function echo_fail {
  # echo first argument in red
  printf "\e[31m✘ ${1}"
  # reset colours back to normal
  printf "\033\e[0m"
}

# display a message in green with a tick by it
# example
# echo echo_fail "Yes"
function echo_pass {
  # echo first argument in green

  printf "\e[32m✔"
  # reset colours back to normal
  printf "\033\e[0m"
}

# echo pass or fail
# example
# echo echo_if 1 "Passed"
# echo echo_if 0 "Failed"
function echo_if {
  if [ $1 == 1 ]; then
    echo_pass $2
  else
    echo_fail $2
  fi
}

function check_program_installed_version {
  echo $1   "$(echo_if $(program_is_installed $1)) $($1 --version)"
}

# ============================================== Functions

clear
echo "Checking for installed programs ..."
echo "  "

for i in "${programs[@]}"
do
   echo $(check_program_installed_version $i)
done

echo "  "
echo "Checking for Github SSH Authentication"
echo " "
ssh -T git@github.com
echo " "

echo "Done"
echo " "
