https://kyverno.io/docs/installation/methods/


The purpose of the helm_release resource named "kyverno_policies" is to manage the installation of the Kyverno Pod Security Standard policies chart.

Kyverno itself is a policy engine for Kubernetes, allowing you to enforce policies for resources in your cluster. The Kyverno Pod Security Standard policies, on the other hand, are a set of pre-defined policies that implement the Kubernetes Pod Security Standards. These policies help enhance the security posture of your Kubernetes cluster by enforcing best practices for pod security.

By deploying the Kyverno Pod Security Standard policies, you can ensure that your Kubernetes cluster follows industry-standard security practices related to pod security.

Here's why you might want to use a separate helm_release resource for the Kyverno Pod Security Standard policies:

Separation of Concerns: Keeping the installation of Kyverno and its policies separate allows for better organization and management of resources.
Modularity: You can choose to install Kyverno without the additional policies if you only need the policy engine functionality. Conversely, you can install the policies separately if you already have Kyverno installed and want to add additional policies later.
Flexibility: Managing the policies as a separate Helm release gives you more flexibility in terms of versioning, configuration, and lifecycle management.
Overall, using a separate helm_release resource for the Kyverno Pod Security Standard policies allows you to manage and deploy these policies independently from the main Kyverno application release.


https://kyverno.io/blog/2023/06/12/using-kyverno-with-pod-security-admission/

https://kyverno.io/blog/2024/04/26/kyverno-1.12-released/

https://www.datree.io/helm-chart/kyverno-crds-kyverno

https://kyverno.io/docs/installation/methods/


https://kyverno.io/policies/?policytypes=Karpenter