#!/bin/bash
# Load framework
source .devcontainer/util/source_framework.sh

printInfoSection "Running integration Tests for $RepositoryName"
#assertRunningPod dynatrace operator

#assertRunningPod dynatrace activegate

#assertRunningPod dynatrace oneagent

assertRunningPod kube-system coredns

#assertRunningApp 30100

#exposeOnHttp

#assertRunningApp 80



