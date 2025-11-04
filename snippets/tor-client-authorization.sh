# Configure client authorization
cat << EOF >> /etc/tor/custom
ClientOnionAuthDir /etc/tor/onion_auth
EOF
umask go=
TOR_AUTH="$(cat client.auth_private)"
TOR_HOST="${TOR_AUTH%%:*}.onion"
mkdir -p /etc/tor/onion_auth
cat << EOF > /etc/tor/onion_auth/client.auth_private
${TOR_AUTH}
EOF
chown -R tor:tor /etc/tor/onion_auth
service tor restart
