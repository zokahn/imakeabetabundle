$Env:DOCKER_TLS_VERIFY = 1
$Env:COMPOSE_TLS_VERSION = "TLSv1_2"
$Env:DOCKER_CERT_PATH = Split-Path $script:MyInvocation.MyCommand.Path
$Env:DOCKER_HOST = "tcp://docker.zokahn.local:443"

$d = Split-Path $script:MyInvocation.MyCommand.Path
if (Get-Command kubectl -ErrorAction Ignore) {
        $Env:KUBECONFIG = $null
        kubectl config set-cluster ucp_docker.zokahn.local:6443_zokahn --server https://docker.zokahn.local:6443 --certificate-authority "$(Join-Path $d ca.pem)" --embed-certs
        kubectl config set-credentials ucp_docker.zokahn.local:6443_zokahn --client-key "$(Join-Path $d key.pem)" --client-certificate "$(Join-Path $d cert.pem)" --embed-certs
        kubectl config set-context ucp_docker.zokahn.local:6443_zokahn --user ucp_docker.zokahn.local:6443_zokahn --cluster ucp_docker.zokahn.local:6443_zokahn
}
$Env:KUBECONFIG = Join-Path $d kube.yml

#
# Bundle for user zokahn
# UCP Instance ID 17gs421odelgufgyjialrnk0a
#
# This admin cert will also work directly against Swarm and the individual
# engine proxies for troubleshooting.  After sourcing this env file, use
# "docker info" to discover the location of Swarm managers and engines.
# and use the --host option to override $DOCKER_HOST
#
# Run this command from within this directory to configure your shell:
# Import-Module .\env.ps1
