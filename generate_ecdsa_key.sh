if [ -z "$1" ]; then
  echo "Usage: $0 peerName"
  exit 1
fi

PEERNAME=$1

echo "Generating key files for peer '"$PEERNAME"', please wait."

touch $PEERNAME.secret
chmod 600 $PEERNAME.secret
/usr/local/bin/ecdsakeygen -s > $PEERNAME.secret
/usr/local/bin/ecdsakeygen -p < $PEERNAME.secret > $PEERNAME.pub
echo "Key files for peer '"$PEERNAME"' successfully generated."

exit 0

