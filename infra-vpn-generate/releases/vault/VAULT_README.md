1. Secrets with postgres-password
postgres-secret.yaml
2. Create DM use Zalando postgresql operator
postgres.yaml
3. Prepear db for vault backend
helm install create-vault-db ./create_vault_db/ -n vault 
check actual password in values
4. 
vault operator init 
kubectl exec -n vault vault-0 -- vault operator init -tls-skip-verify -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
5. unseal
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]") && \
kubectl exec -n vault vault-0 -- vault operator unseal -tls-skip-verify $VAULT_UNSEAL_KEY && \
kubectl exec -n vault vault-1 -- vault operator unseal -tls-skip-verify $VAULT_UNSEAL_KEY && \
kubectl exec -n vault vault-2 -- vault operator unseal -tls-skip-verify $VAULT_UNSEAL_KEY