# vim: ft=zsh

alias ddr="docker run -it --rm"
alias ds=docker-swarm
alias dm=docker-machine
alias dc=docker-compose

MACHINE_ENV=~/.docker/.machine.sh

function reset_env() {
  cat <<-END > $MACHINE_ENV
unset DOCKER_API_VERSION
unset DOCKER_HOST

unset DOCKER_TLS_VERIFY
unset DOCKER_CERT_PATH

unset DOCKER_MACHINE_NAME

unset DOCKER_IP

unset ETCDCTL_PEERS
unset KUBERNETES_MASTER
unset KUBECONFIG
unset HELM_HOST

END
}

function use_local() {
  reset_env
  cat <<-END >> $MACHINE_ENV
export DOCKER_HOST=unix:///var/run/docker.sock
END
}

function use_solo() {
  local vm_ip=$(corectl q -i k8solo-01)
  if [ -z "$vm_ip" ]; then
    echo "can't find ip for k8solo-01; check 'corectld status'"
    exit 1
  else
    echo found k8solo-01 at $vm_ip
  fi

  reset_env

  cat <<-END >> $MACHINE_ENV
export PATH=${HOME}/kube-solo/bin:\$PATH

export ETCDCTL_PEERS=http://$vm_ip:2379
export KUBERNETES_MASTER=http://$vm_ip:8080
export KUBECONFIG=~/kube-solo/kube/kubeconfig
export HELM_HOST=$vm_ip:32767

export DOCKER_IP=$vm_ip

export DOCKER_HOST=tcp://$vm_ip:2375
export DOCKER_API_VERSION=1.23
END
}

function dmu
{
  echo using dockerhost "$@"

  case "$*" in
    local) use_local ;;

    solo) use_solo ;;

    *)
      reset_env
      echo "export DOCKER_IP=$(docker-machine ip "$@")" >> $MACHINE_ENV
      docker-machine env "$@" >> $MACHINE_ENV
      ;;
  esac

  source $MACHINE_ENV
  echo $DOCKER_HOST
}

if [ -e $MACHINE_ENV ]; then
  source $MACHINE_ENV
fi

if [ -e ~/.auth/digitalocean ]; then
  source ~/.auth/digitalocean
fi
