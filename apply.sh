NS_1='cheuser-che'
NS_2='cheuser-che-2'
NS_TRAEFIK='traefik-che'
oc login -u kubeadmin -p HeJWN-ckbCA-Q96Ds-Sj763 https://api.crc.testing:6443
oc apply -f 001-rbac.yaml
oc apply -f 002-definitions.yaml

oc new-project $NS_TRAEFIK
oc apply -f 003-deployment-traefik.yaml -n $NS_TRAEFIK
oc apply -f 004-os-routes.yaml -n $NS_TRAEFIK
oc apply -f 007-resources.yaml --namespace=$NS_TRAEFIK

oc new-project $NS_1
oc apply -f 005-deployment-whoami.yaml -n $NS_1


oc new-project $NS_2
oc apply -f 005-deployment-whoami.yaml -n $NS_2

sleep 120s
BASE_URL=$(oc get route traefik-web  -n ${NS_TRAEFIK}  -o jsonpath='{.spec.host}')
echo ${BASE_URL}
echo 'First service'
echo "oc get services -n ${NS_1}"
oc get services -n ${NS_1}

curl -v http://${BASE_URL}/whoami
echo 'Second service'
echo "oc get services -n ${NS_2}"
oc get services -n ${NS_2}
curl -v http://${BASE_URL}/whoami2

