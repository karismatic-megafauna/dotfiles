#########################
# Change your db!
#########################

# copy the database yml and paste it in your config 
cpdb()
{
  #find all places where there is a database.yml
  local database_locs="find ~/ -maxdepth 5 -path '*config/database.yml*' | sed 's/home//;s/vagrant//;s/\///;s/\///;s/\///'"

  #set second arg to procore if not defined
  local dir=${2:-procore}

  #check and see if directroy exists
  if [ ! -d ~/$dir ]; then
    echo "$dir does not exist, try one of these:"
    echo "--------------------------------------"
    eval $database_locs
    return
  fi

  #check if database file exists and cp it
  if [ $1 == '-l' ]; then 
    cp ~/.database_configs/database_local.yml ~/$dir/config/database.yml
    echo "now using your [local] database file in the [$dir] directory"
  elif [ $1 == '-o' ]; then
    cp ~/.database_configs/database_office.yml ~/$dir/config/database.yml
    echo "now using your [office] database file in the [$dir] directory"
  elif [ $1 == '-r' ]; then
    cp ~/.database_configs/database_remote_office.yml ~/$dir/config/database.yml
    echo "now using your [remote office] database file in the [$dir] directory"
    echo "you will need to run 'ssh db1.office.procore' to set this up"
  else
    echo "specify [-l], [-r] or [-o], to change database file"
  fi
}

#########################
# Get your Node info 
#########################

nodeStatus()
{
  echo "What's your NODE like?" 
  echo "-------------------------"

  NVM_VERSION=$(nvm --version)
  if [ $? -eq 0 ];then
    printf "nvm --version : %s\n" "$NVM_VERSION"
  else
    echo "No nvm! Drat!"
  fi 

  NODE_VERSION=$(nvm current)
  if [ $? -eq 0 ];then
    printf "nvm current   : %s\n" "$NODE_VERSION"
  else
    echo "No node! Drat!"
  fi 

  NPM_VERSION=$(npm -v)
  if [ $? -eq 0 ];then
    printf "npm -v        : %s\n" "$NPM_VERSION"
  else
    echo "No nvm! Drat!"
  fi 

  NPM_VERSION=$(nodejs -v)
  if [ $? -eq 0 ];then
    printf "npm -v        : %s\n" "$NPM_VERSION"
  else
    echo "wut?"
  fi 
}

# something about this was crashing my tmux split...
# neededCommands()
# {
#   my_needed_commands="sed awk lsof who"
#
#   missing_counter=0
#   for needed_command in $my_needed_commands; do
#     if ! hash "$needed_command" >/dev/null 2>&1; then
#       printf "Command not found in PATH: %s\n" "$needed_command" >&2
#       ((missing_counter++))
#     fi
#   done
#
#   if ((missing_counter > 0)); then
#     printf "Minimum %d commands are missing in PATH, aborting\n" "$missing_counter" >&2
#     exit 1
#   fi
# }
