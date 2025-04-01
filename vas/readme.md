Subject: Resolution of CoreDNS Addon Configuration Conflict

Dear Team,

I hope this message finds you well.

I would like to address the recent issue we encountered with the CoreDNS add-on's custom configuration. Previously, we modified the CoreDNS ConfigMap to include the directive `forward . 10.125.16.5 10.125.16.29`, replacing the default `forward . /etc/resolv.conf`. These IP addresses are sourced from our DHCP options set.

During the add-on update process, the system attempts to revert the CoreDNS ConfigMap to its default settings, specifically `forward . /etc/resolv.conf`. This action conflicts with our customized configuration, leading to update failures.

To resolve this issue, we should utilize the `ResolveConflicts: PRESERVE` option in our CloudFormation template. This setting ensures that existing custom configurations remain intact during add-on updates. The updated CloudFormation template for the CoreDNS add-on is as follows:


```yaml
Type: AWS::EKS::Addon
Properties:
  AddonName: coredns
  AddonVersion: v1.9.3-eksbuild.7
  ClusterName: mycluster
  ResolveConflicts: PRESERVE
```


By implementing the `ResolveConflicts: PRESERVE` option, we can prevent the overwriting of our custom configurations during future updates. This approach is recommended to maintain the integrity of our settings. citeturn0search0

Please ensure that this adjustment is applied to maintain the stability and desired configuration of our CoreDNS deployment.

Best regards,

[Your Name] 
