# THIS IS FOR ASTRA - NEEDS REWRITE FOR OSS - LLP 04.27.21

#!/bin/bash


which gsed > /dev/null || (echoerr "Please ensure that gsed is in your PATH" && exit 1)
which curl > /dev/null || (echoerr "Please ensure that curl is in your PATH" && exit 1)
which gron > /dev/null || (echoerr "Please ensure that gron is in your PATH" && exit 1)

echoerr() { echo "$@" 1>&2; }
badopt() { echoerr "$@"; help='true'; }
opt() { if [[ -z ${2-} ]]; then badopt "$1 flag must be followed by an argument"; fi; export $1="$2"; }
exit_on_failure() { echoerr "Test FAILED" && exit 1; }

while [[ $# -gt 0 ]]; do
  arg="$1"
  case $arg in
    --username|-u)     shift; opt username "$1"; shift;;
    --password|-p)     shift; opt password "$1"; shift;;
    --token|-t)        shift; opt token "$1"; shift;;
    --keyspace|-k)     shift; opt keyspace "$1"; shift;;
    --help|-h)                opt help true; shift;;
    *) shift;;
  esac
done

if [[ -n ${help-} ]]; then
  echoerr "Usage: $0"
  echoerr "    -u, --username     <username>      The username to use for authentication. Can also be provided as environment variable USERNAME."
  echoerr "    -p, --password     <password>      The password to use for authentication. Can also be provided as environment variable PASSWORD"
  echoerr "    -t, --token        <token>         Token for authenticating and authorization requests in lieu of username/password. Can also be provided as environment variable TOKEN."
  echoerr "    -k, --keyspace     <keyspace>      The keyspace to use for testing. If not provided will default to 'testks'"
  echoerr "    -h, --help"
  exit 1
fi


if [[ -z $username ]]; then
    username=$USERNAME
fi

if [[ -z $password ]]; then
    password=$PASSWORD
fi

if [[ -z $token ]]; then
    token=$TOKEN
fi

if [[ -z $token ]]; then
    if [[ -z $username || -z $password ]]; then
        echoerr "Must provide either username and password or token." && exit 1
    fi
fi

# No token provided so generate one
if [[ -z $token ]]; then
    token=$(curl -s -L -X POST 'http://localhost:8081/v1/auth' \
    -H 'Content-Type: application/json' \
    --data-raw '{
      "username": "$username",
      "password": "$password"
    }' | jq -r -e '.authToken')
fi


if [[ -z $keyspace ]]; then
    keyspace="testks"
fi


export AUTH_TOKEN=$token
