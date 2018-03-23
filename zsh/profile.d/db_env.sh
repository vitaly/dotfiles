function db_con_info() {
  echo
  echo == POSTGRES CONNECTION:
  echo PGUSER=$PGUSER
  echo PGPASSWORD=$PGPASSWORD
  echo PGHOST=$PGHOST
  echo PGPORT=$PGPORT
  echo PGDATABASE=$PGDATABASE
}

function db_reset() {
  unset PGHOST
  unset PGPORT
  unset PGUSER
  unset PGPASSWORD
  unset PGDATABASE
}

# postgres://user:password@host:port/database
function db_parse() {
  db_reset

  local url user password host port database

  read url

  if echo $url | grep -q postgres://; then
    url=`echo $url | cut -d/ -f3-`
  fi

  echo DATABASE URL: $url
  echo

  if echo $url | grep -q @; then
    user=`echo $url | cut -d@ -f1 | cut -d: -f 1`
    password=`echo $url | cut -d@ -f1 | cut -d: -f 2`
    url=`echo $url | cut -d@ -f2`
  fi

  database=`echo $url | cut -s -d/ -f2`
  url=`echo $url | cut -d/ -f1`

  host=`echo $url | cut -d: -f1`
  port=`echo $url | cut -s -d: -f2`

  [ -n "$user" ] && export PGUSER=$user
  [ -n "$password" ] && export PGPASSWORD=$password
  [ -n "$host" ] && export PGHOST=$host
  [ -n "$port" ] && export PGPORT=$port
  [ -n "$database" ] && export PGDATABASE=$database

  db_con_info
}

function db_remote() {
  heroku config "$@" | grep DATABASE_URL | db_parse
}

function db_local {
  echo "$USER:@localhost/$USER" | db_parse
}

db_local > /dev/null
