#!/bin/sh
set -eu

cat > /var/lib/pgadmin/servers.json <<EOF
{
  "Servers": {
    "1": {
      "Name": "Nugget PostgreSQL",
      "Group": "NuggetGroup",
      "Host": "s2db",
      "Port": 5432,
      "MaintenanceDB": "${DB_NAME}",
      "Username": "${DB_USER}",
      "ConnectionParameters": {
        "sslmode": "prefer",
        "connect_timeout": 10
      }
    }
  }
}
EOF

exec /entrypoint.sh "$@"
