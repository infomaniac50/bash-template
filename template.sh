#!/bin/bash

thisscript=`readlink -fn "$0"`
basedir=`dirname $thisscript`
systemdir="$basedir/system"
userdir="$basedir/user"
template=""
invoke_as=`basename $0`

function usage
{
  echo "$invoke_as <subcommand> <arguments>"
}

function example
{
  cat <<ENDOFSTRING
#!/bin/bash

echo "These are your commands."
echo "Run anything you need in here."
echo "If it exists you can run it."
echo "Think of this file as a recipie."
ENDOFSTRING
}

function find_template
{
  # User templates override system templates.
  # Executable templates override regular templates.

  # Search for regular templates.
  for t in $systemdir/*.txt; do
    if [[ "$systemdir/$1.txt" == "$t" ]]; then
      template=$t
    fi
  done

  for t in $userdir/*.txt; do
    if [[ "$userdir/$1.txt" == "$t" ]]; then
      template=$t
    fi
  done

  # Search for executable templates.
  for t in $systemdir/*.sh; do
    if [[ "$systemdir/$.sh" == "$t" ]]; then
      template=$t
    fi
  done

  for t in $userdir/*.sh; do
    if [[ "$userdir/$1.sh" == "$t" ]]; then
      template=$t
    fi
  done
}

function new_template
{
  find_template $1

  if [[ -z $template ]]; then
    echo "Template not found"
    exit 1
  fi

  shift

  case $template in
    *.txt )
      if [[ -z "$1" ]]; then
        echo "You must provide a file name for regular templates."
        exit 1
      fi

      cp -air $template $1
      ;;
    *.sh )
      source $template
      ;;
  esac
}

function list_templates
{
  echo 'Plain Templates'
  if [[ $(ls -1 $systemdir/*.txt 2> /dev/null | wc -l) != "0" ]]; then
    echo ''
    echo 'System:'
    for t in $systemdir/*.txt; do
      echo -e "\t`basename ${t%.txt}`"
    done
  fi

  if [[ $(ls -1 $userdir/*.txt 2> /dev/null | wc -l) != "0" ]]; then
    echo ''
    echo 'User:'
    for t in $userdir/*.txt; do
      echo -e "\t`basename ${t%.txt}`"
    done
  fi

  echo ''

  echo 'Executable Templates'
  if [[ $(ls -1 $systemdir/*.sh 2> /dev/null | wc -l) != "0" ]]; then
    echo ''
    echo 'System:'
    # Search for executable templates.
    for t in $systemdir/*.sh; do
      echo -e "\t`basename ${t%.sh}`"
    done
  fi

  if [[ $(ls -1 $userdir/*.sh 2> /dev/null | wc -l) != "0" ]]; then
    echo ''
    echo 'User:'
    for t in $userdir/*.sh; do
      echo -e "\t`basename ${t%.sh}`"
    done
  fi
}

function main
{
  if [[ $invoke_as == "new" ]]; then
    action="new"
  else
    action="$1"
    shift
  fi

  case $action in
    "usage" )
      usage
      exit 0
      ;;
    "example" )
      example
      exit 0
      ;;
    "help" )
      usage
      exit 0
      ;;
  esac

  if [[ -z $action ]]; then
    usage
    exit 1
  fi

  case $action in
    "new" )
      new_template "$@"
      ;;
    "list" )
      list_templates
      ;;
  esac
}

main "$@"
