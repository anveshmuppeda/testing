Here’s your **entire Kubernetes Lunch & Learn + Game Day Plan**, structured as **sessions** for smooth execution. Each session includes **learning objectives, hands-on labs, and Game Day challenges** to reinforce learning with real-world troubleshooting.  

---

# **📅 Kubernetes Lunch & Learn + Game Day Series (Amazon EKS + ADO + CFT/CDK + Velero)**  
🎯 **Total Sessions:** 12 Learning + 7 Game Days  
🛠 **Hands-on Labs & Troubleshooting Challenges in Each Session**  
🚀 **Focus:** Real-world Kubernetes problems, EKS best practices, automation  

---

## **🚀 Session 1: Introduction to Kubernetes & EKS**  
🎓 **Topics Covered:**  
- What is Kubernetes? Why do we need it?  
- Kubernetes core components: Nodes, Pods, Deployments, Services  
- **Amazon EKS vs. self-managed Kubernetes**  
- EKS Networking overview (VPC CNI, ENIs, Security Groups)  

🛠 **Hands-on Lab:**  
✅ **Deploy an EKS cluster using AWS CDK**  
✅ Deploy a simple **Nginx application** on EKS  

---

## **📦 Session 2: Understanding Kubernetes Objects**  
🎓 **Topics Covered:**  
- Pods, ReplicaSets, Deployments, StatefulSets  
- Services (ClusterIP, NodePort, LoadBalancer)  
- ConfigMaps & Secrets  

🛠 **Hands-on Lab:**  
✅ Deploy a **multi-container app**  
✅ Implement **ConfigMaps & Secrets**  

🎮 **Game Day 1: Debugging Broken Kubernetes Objects**  
🚨 **Failures:** Remove ConfigMaps, deploy an incorrect container image  
⚡ **Challenges:** Fix failed deployments, restore broken pods  

---

## **🌐 Session 3: Ingress & Traffic Routing in Kubernetes**  
🎓 **Topics Covered:**  
- Difference between Services & Ingress  
- Ingress Controllers (AWS ALB Ingress vs. Nginx Ingress)  
- TLS termination & HTTPS routing  

🛠 **Hands-on Lab:**  
✅ Deploy an **Nginx Ingress Controller**  
✅ Set up **host-based & path-based routing**  

🎮 **Game Day 2: Debugging Ingress Issues**  
🚨 **Failures:** Misconfigured Ingress rules, delete TLS certs  
⚡ **Challenges:** Restore proper routing & fix SSL issues  

---

## **💾 Session 4: Storage & Persistent Volumes in EKS**  
🎓 **Topics Covered:**  
- Persistent Volumes (PVs) & Persistent Volume Claims (PVCs)  
- AWS **EBS, EFS, FSx** for Kubernetes  

🛠 **Hands-on Lab:**  
✅ Deploy **MySQL with EBS-backed PVC**  
✅ Deploy a **shared storage app with EFS**  

🎮 **Game Day 3: Storage Failures & Recovery**  
🚨 **Failures:** Detach EBS volume, delete PVC  
⚡ **Challenges:** Restore database state  

---

## **📈 Session 5: Autoscaling in Kubernetes & EKS**  
🎓 **Topics Covered:**  
- Horizontal Pod Autoscaler (HPA)  
- Cluster Autoscaler for EKS  

🛠 **Hands-on Lab:**  
✅ Implement **HPA with CPU-based scaling**  
✅ Enable **Cluster Autoscaler**  

🎮 **Game Day 4: Load Test & Autoscaling Challenges**  
🚨 **Failures:** Simulate **high traffic load**, limit node pool size  
⚡ **Challenges:** Tune HPA thresholds, optimize Cluster Autoscaler  

---

## **🛠 Session 6: Setting Up & Managing Amazon EKS Cluster with CFT & CDK**  
🎓 **Topics Covered:**  
- **EKS Cluster Deployment:** AWS CloudFormation (CFT) vs. AWS CDK  
- **Worker Node Management:** Managed Node Groups & Self-managed Nodes  
- **Upgrading Cluster & Worker Node Group Versions**  
- **Handling Worker Node Failures & Auto-recovery**  

🛠 **Hands-on Lab:**  
✅ Deploy an **EKS Cluster using AWS CDK**  
✅ Manage **Worker Nodes using CloudFormation (CFT)**  
✅ Upgrade **Cluster & Add-on Versions**  

🎮 **Game Day 5: EKS Cluster Outages & Worker Node Failures**  
🚨 **Failures:** Delete worker node, restrict IAM permissions  
⚡ **Challenges:** Restore worker nodes, fix IAM role misconfigurations  

---

## **🚀 Session 7: CI/CD for Kubernetes with Azure DevOps (ADO) & GitOps**  
🎓 **Topics Covered:**  
- Setting up **ADO Pipelines** for Kubernetes  
- Deploying applications to EKS using **Helm & ArgoCD**  

🛠 **Hands-on Lab:**  
✅ Configure **ADO CI/CD pipeline for Kubernetes**  
✅ Implement **GitOps with ArgoCD**  

🎮 **Game Day 6: CI/CD Failures & Rollbacks**  
🚨 **Failures:** Deploy incorrect Helm chart, introduce a pipeline failure  
⚡ **Challenges:** Rollback deployment using ArgoCD  

---

## **🔎 Session 8: Observability & Monitoring in EKS**  
🎓 **Topics Covered:**  
- **Prometheus & Grafana** for Metrics  
- **AWS CloudWatch** for Logs  

🛠 **Hands-on Lab:**  
✅ Install **Prometheus + Grafana**  
✅ Configure **CloudWatch Logs**  

🎮 **Game Day 7: Debugging an Unmonitored Failure**  
🚨 **Failures:** Disable application logging, remove Prometheus alerts  
⚡ **Challenges:** Set up proper logging & monitoring  

---

## **💾 Session 9: Disaster Recovery (DR) in EKS with Velero**  
🎓 **Topics Covered:**  
- Kubernetes **backup & restore** strategies  
- Velero architecture & setup in EKS  

🛠 **Hands-on Lab:**  
✅ Install **Velero and take a namespace backup**  
✅ Simulate **data loss & restore using Velero**  

🎮 **Game Day 8: DR Scenario – Simulating Cluster Failure**  
🚨 **Failures:** Delete a namespace & associated PVs  
⚡ **Challenges:** Restore all resources using Velero  

---

## **⚡ Session 10: Troubleshooting & Debugging in EKS**  
🎓 **Topics Covered:**  
- Debugging tools (`kubectl logs`, `kubectl exec`, `stern`)  
- Identifying **CrashLoopBackOff, ImagePullBackOff** errors  

🛠 **Hands-on Lab:**  
✅ Diagnose common Kubernetes errors  
✅ Use **AWS CloudWatch Logs Insights**  

🎮 **Game Day 9: Kubernetes Chaos Engineering**  
🚨 **Failures:** Induce **high memory usage (OOMKilled)**  
⚡ **Challenges:** Identify & fix issues using monitoring tools  

---

## **🔥 Final Thoughts & Next Steps**  
✅ **This plan ensures hands-on learning + real-world troubleshooting experience**  
✅ **CloudFormation & CDK templates for EKS setup available**  
✅ **ADO Pipeline YAML & ArgoCD GitOps workflows available**  
✅ **Velero backup & restore scripts available**  

Would you like additional **automation scripts, sample failures, or detailed workshop guides?** 🚀🔥
