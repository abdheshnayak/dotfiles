#! /usr/bin/env bash

namespace=$1
deployment=$2
container=$3

# from env
x=""

# echo "Namespace: $namespace, Deployment: $deployment"

for item in $(kubectl get deploy/$deployment -n $namespace -o json | jq -r .spec.template.spec.containers[].envFrom[]?.secretRef.name | xargs)
do
  # kubectl get secret/$item -n $namespace -o json | jq -r -e '.data|keys|.[]' | xargs
  if [[ $item  != "null" ]]; then
    for cItem in $(kubectl get secret/$item -n $namespace -o json | jq -r -e '.data|keys|.[]' | xargs)
    do
      x+="echo $cItem=\'\"\$$cItem\"\';"
    done
  fi
done

for item in $(kubectl get deploy/$deployment -n $namespace -o json | jq -r .spec.template.spec.containers[].envFrom[]?.configMapRef.name | xargs)
do
  if [[ $item  != "null" ]]; then
    for cItem in $(kubectl get config/$item -n $namespace -o json | jq -r -e '.data|keys|.[]' | xargs)
    do
      x+="echo $cItem=\'\"\$$cItee\"\';"
    done
  fi
done

for item in $(kubectl get deploy/$deployment -n $namespace -o json | jq -r .spec.template.spec.containers[].env[]?.name | xargs)
do
  x+="echo $item=\'\"\$$item\"\';"
done

podName="$deployment-grab-k8s-env-$RANDOM"

kubectl get deploy/$deployment -n $namespace -o json | jq --arg name $podName --arg ns $namespace '.spec.template | .spec.containers[].args=[] | .spec.containers[].command=["sleep", "5"] | .spec.containers[].resources={} | .spec.containers[].image="nxtcoder17/alpine:nonroot" | .spec.containers[].imagePullPolicy="IfNotPresent" | del(.spec.containers[].livenessProbe)| del (.spec.containers[].readinessProbe) | .metadata={} | .metadata.name=$name| .metadata.namespace=$ns | .apiVersion="v1" | .kind="Pod"' | kubectl apply -n "$namespace" -f - > /dev/null

# run a pod with same everything to grab env
kubectl -n $namespace wait --for=condition=Ready=True pod/$podName > /dev/null

if [ -z $container ]; then
  kubectl -n "$namespace" exec pod/$podName  -- sh -c "$x"
else
  kubectl -n "$namespace" exec pod/$podName -c "$container" -- sh -c "$x"
fi

kubectl -n "$namespace" delete pod/$podName &> /dev/null
