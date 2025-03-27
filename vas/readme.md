Here's a step-by-step guide to upgrade your EKS cluster from **1.25 → 1.28** using **CloudFormation (CFT)**, inspired by ITHAKA Tech's approach:

---

### **Step 1: Prepare Your CFT for Sequential Control Plane Upgrades**
1. **Update Control Plane Version in CFT**:
   - Modify your EKS cluster resource in the CFT to incrementally upgrade the control plane through **1.26 → 1.27 → 1.28**:
     ```yaml
     Resources:
       EKSCluster:
         Type: AWS::EKS::Cluster
         Properties:
           Name: !Ref ClusterName
           Version: "1.26"  # First upgrade to 1.26
           RoleArn: !GetAtt ClusterRole.Arn
           ResourcesVpcConfig:
             SubnetIds: !Ref SubnetIds
             SecurityGroupIds: !Ref SecurityGroupIds
     ```
   - Apply the CFT stack update for each version sequentially (1.26 → 1.27 → 1.28).

2. **Use Change Sets**:
   - For each minor version upgrade, create a CloudFormation Change Set to preview changes before execution.

---

### **Step 2: Update Node Groups to Skip Intermediate Versions**
1. **Update Node Group AMI**:
   - Directly update worker nodes to **1.28** after all control plane upgrades are complete. Modify the node group’s `LaunchTemplate` to use the EKS-optimized AMI for Kubernetes **1.28**:
     ```yaml
     NodeGroup:
       Type: AWS::EKS::Nodegroup
       Properties:
         ClusterName: !Ref ClusterName
         NodegroupName: "ng-1-28"
         Subnets: !Ref SubnetIds
         NodeRole: !GetAtt NodeRole.Arn
         ScalingConfig:
           MinSize: 2
           MaxSize: 5
           DesiredSize: 2
         LaunchTemplate:
           Id: !Ref NodeLaunchTemplate
           Version: !GetAtt NodeLaunchTemplate.LatestVersionNumber
     ```

     In the `LaunchTemplate`, specify the AMI ID for Kubernetes **1.28** (e.g., `ami-0abcdef1234567890`).

2. **Use a Blue/Green Strategy** (Optional):
   - Create a new node group with the **1.28** AMI alongside the existing node group.
   - Drain pods from old nodes:
     ```bash
     kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
     ```
   - Delete the old node group after migration.

---

### **Step 3: Update Add-ons via CFT**
1. **Update EKS Add-ons**:
   - Specify compatible versions for **VPC CNI**, **CoreDNS**, and **kube-proxy** in your CFT:
     ```yaml
     VPCCNIAddon:
       Type: AWS::EKS::Addon
       Properties:
         AddonName: vpc-cni
         ClusterName: !Ref ClusterName
         AddonVersion: "v1.18.0-eksbuild.1"  # Example for 1.28 compatibility
     ```

   - Repeat for `coredns` and `kube-proxy` add-ons.

---

### **Step 4: Handle Deprecated APIs**
1. **Check for Deprecated APIs**:
   - Use `kubectl-convert` or tools like `pluto` to detect deprecated APIs:
     ```bash
     kubectl-convert -f manifests/ --target-version 1.28
     ```
   - Update manifests (e.g., replace `autoscaling/v2beta2` → `autoscaling/v2`).

2. **Update HorizontalPodAutoscaler (HPA)**:
   - Modify HPA manifests to use `apiVersion: autoscaling/v2`.

---

### **Step 5: Automate with Stack Policies (Optional)**
1. **Prevent Accidental Rollbacks**:
   - Apply a stack policy to block updates to the control plane version:
     ```json
     {
       "Statement": [
         {
           "Effect": "Deny",
           "Action": "Update:Modify",
           "Principal": "*",
           "Resource": "LogicalResourceId/EKSCluster",
           "Condition": {
             "StringNotLike": {
               "ResourceType": ["AWS::EKS::Cluster"]
             }
           }
         }
       ]
     }
     ```

---

### **Final CFT Snippet for 1.28**
```yaml
Resources:
  EKSCluster:
    Type: AWS::EKS::Cluster
    Properties:
      Name: !Ref ClusterName
      Version: "1.28"  # Final target version
      RoleArn: !GetAtt ClusterRole.Arn
      ResourcesVpcConfig:
        SubnetIds: !Ref SubnetIds
        SecurityGroupIds: !Ref SecurityGroupIds

  NodeGroup:
    Type: AWS::EKS::Nodegroup
    Properties:
      ClusterName: !Ref ClusterName
      NodegroupName: "ng-1-28"
      Subnets: !Ref SubnetIds
      NodeRole: !GetAtt NodeRole.Arn
      ScalingConfig:
        MinSize: 2
        MaxSize: 5
        DesiredSize: 2
      LaunchTemplate:
        Id: !Ref NodeLaunchTemplate
        Version: !GetAtt NodeLaunchTemplate.LatestVersionNumber

  NodeLaunchTemplate:
    Type: AWS::EC2::LaunchTemplate
    Properties:
      LaunchTemplateName: "eks-1-28"
      LaunchTemplateData:
        ImageId: "ami-0abcdef1234567890"  # EKS-optimized AMI for 1.28
        InstanceType: "t3.medium"
```

---

### **Key Notes**
- **Sequential Control Plane Upgrades**: AWS enforces sequential minor version upgrades for the control plane (1.25 → 1.26 → 1.27 → 1.28).
- **Node Group Flexibility**: Per Kubernetes [version skew policy](https://kubernetes.io/releases/version-skew-policy/), nodes can skip intermediate versions (1.25 → 1.28 directly) if the control plane is on 1.28.
- **Zero Downtime**: Use rolling updates for node groups or blue/green deployment.

For a full example, see [AWS EKS CloudFormation templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-eks-cluster.html).
