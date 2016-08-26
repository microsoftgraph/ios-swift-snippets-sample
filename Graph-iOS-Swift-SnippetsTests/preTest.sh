#!/bin/sh
get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     $( cd -P "$( dirname "$SOURCE" )" )
     pwd
}

FILE="$(get_script_dir)/testUserArgs.json"

/bin/cat <<EOM >$FILE
{
  "test.clientId" : "$1",
  "test.username" : "$2",
  "test.password" : "$3"
}
EOM
