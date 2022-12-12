
# Initialize the ssh key (docker would otherwise cause problems)
ssh -o StrictHostKeyChecking=accept-new root@dev echo "ok"
