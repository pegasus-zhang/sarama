#!/bin/sh

set -ex

${KAFKA_INSTALL_ROOT}/toxiproxy -port 8474 -host 0.0.0.0 &
PID=$!

sleep 2

wget -S --post-data='{"name":"zk1", "upstream":"localhost:21801", "listen":"0.0.0.0:2181"}' localhost:8474/proxies
wget -S --post-data='{"name":"zk2", "upstream":"localhost:21802", "listen":"0.0.0.0:2182"}' localhost:8474/proxies
wget -S --post-data='{"name":"zk3", "upstream":"localhost:21803", "listen":"0.0.0.0:2183"}' localhost:8474/proxies
wget -S --post-data='{"name":"zk4", "upstream":"localhost:21804", "listen":"0.0.0.0:2184"}' localhost:8474/proxies
wget -S --post-data='{"name":"zk5", "upstream":"localhost:21805", "listen":"0.0.0.0:2185"}' localhost:8474/proxies

wget -S --post-data='{"name":"kafka1", "upstream":"localhost:26667", "listen":"0.0.0.0:6667"}' localhost:8474/proxies
wget -S --post-data='{"name":"kafka2", "upstream":"localhost:26668", "listen":"0.0.0.0:6668"}' localhost:8474/proxies
wget -S --post-data='{"name":"kafka3", "upstream":"localhost:26669", "listen":"0.0.0.0:6669"}' localhost:8474/proxies
wget -S --post-data='{"name":"kafka4", "upstream":"localhost:26670", "listen":"0.0.0.0:6670"}' localhost:8474/proxies
wget -S --post-data='{"name":"kafka5", "upstream":"localhost:26671", "listen":"0.0.0.0:6671"}' localhost:8474/proxies

wait $PID
