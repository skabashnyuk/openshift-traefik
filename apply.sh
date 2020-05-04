NS='cheuser-che'
oc login -u kubeadmin -p HeJWN-ckbCA-Q96Ds-Sj763 https://api.crc.testing:6443
oc apply -f 001-rbac.yaml
oc apply -f 002-definitions.yaml
oc new-project $NS
oc project $NS
oc apply -f 003-deployment-traefik.yaml -n $NS
oc apply -f 004-deployment-whoami.yaml -n $NS
oc apply -f 006-os-routes.yaml -n $NS
oc apply -f 007-resources.yaml --namespace=default

