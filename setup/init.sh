#!/bin/sh

cd `dirname ${BASH_SOURCE:-$0}`
WD=`pwd`
BN=`basename ${BASH_SOURCE:-$0}`

if [ ! -e .env ] ; then
  echo "\".env\" doesn't exist. Abort."
  exit 1
fi

. ./.env

function replaceStr() {
  find .. -type d -name ".git" -prune -o -type f \
    -regex ".*\.\(yml\|sh\|ini\|json\|js\|xml\|php\|rb\|py\)" \
    -not -name ${BN} -print | xargs sed -i "s%$1%$2%g"
  find ../proxy/mount/vhost.d -type f -print | xargs sed -i "s%$1%$2%g"
}

function generateHash() {
  local needle=$1
  local cmd=$2
  local temp=/tmp/shw.tmp
  find .. -type d -name ".git" -prune -o -type f \
    -regex ".*\.\(yml\|sh\|ini\|json\|js\|xml\|php\|rb\|py\)" \
    -not -name ${BN} -print | \
    xargs fgrep -rl "$needle" | \
    while read file; do \
      rm -f $temp; \
      while IFS= read -r line || [ -n "${line}" ]; do \
        while [[ $line = *"$needle"* ]]; do \
          repl=`$cmd`; \
          line=${line/$needle/$repl}; \
        done; \
        printf '%s\n' "$line" >> $temp; \
      done < $file; \
      mv -f $temp $file; \
    done
  rm -f $temp
}


# Language/Local
replaceStr "<LANG>" "${LANG}"
replaceStr "<LOCALE>" "${LOCALE}"

echo "\"<LANG>\" has been replaced with \"${LANG}\" and \"<LOCALE>\" has been replaced with \"${LOCALE}\"."


# Timezone
replaceStr "<TZ>" "${TZ}"

echo "\"<TZ>\" has been replaced with \"${TZ}\"."


# Local IP
replaceStr "<LOCAL_IP>" "${LOCAL_IP}"

echo "\"<LOCAL_IP>\" has been replaced with \"${LOCAL_IP}\"."


# Domain
replaceStr "<DOMAIN>" "${DOMAIN}"

# Rename nginx-proxy vhost.d files
cd ../proxy/mount/vhost.d
ls | sed -n "s/\(.*\)SHW_DOMAIN\(.*\)/mv \0 \1${DOMAIN}\2/p" | bash
cd ${WD}

echo "\"<DOMAIN>\" has been replaced with \"${DOMAIN}\" and rename nginx-proxy vhost.d files."


# Keycloak Realm
replaceStr "<REALM>" "${REALM}"

echo "\"<REALM>\" has been replaced with \"${REALM}\"."


# Protocol
if "${SSL}" ; then
  # <PROTOCOL> to https
  replaceStr "<PROTOCOL>" "https"

  # Remove #SSL#
  replaceStr "#SSL#" ""

  echo "\"<PROTOCOL>\" has been replaced with \"https\" and \"#SSL#\" has been removed."
else
  # <PROTOCOL> to http
  replaceStr "<PROTOCOL>" "http"

  # Remove #NO_SSL#
  replaceStr "#NO_SSL#" ""

  echo "\"<PROTOCOL>\" has been replaced with \"http\" and \"#NO_SSL#\" has been removed."
fi


# Disable HSTS
if "${SSL}" && ! "${HSTS}" ; then
  # Remove #NO_HSTS#
  replaceStr "#NO_HSTS#" ""

  echo "\"#NO_HSTS#\" has been removed."
fi


# Self-signed Certification
if "${SSL}" && "${SELF}" ; then
  # Remove #SELF_SIGN#
  replaceStr "#SELF_SIGN#" ""

  echo "\"#SELF_SIGN#\" has been removed."
  echo "You should run \"createselfsigncert.sh\" and \"registerselfsigncert.sh\"."
fi


# SMTP Server
replaceStr "<SMTP_SERVER>" "${SMTP_SERVER}"
replaceStr "<SMTP_PORT>" "${SMTP_PORT}"

echo "\"<SMTP_SERVER>\" has been replaced with \"${SMTP_SERVER}\" and \"<SMTP_PORT>\" has been replaced with \"${SMTP_PORT}\"."


# Random String
generateHash "<BASE64_48>" "openssl rand -base64 36"
generateHash "<ALNUM_48>" "openssl rand -hex 24"

echo "\"<BASE64_48>\" and \"<ALNUM_48>\" have been replaced with random hash."

echo "Done."
exit 0
