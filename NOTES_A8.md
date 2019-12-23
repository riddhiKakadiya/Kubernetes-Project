```yaml
- name: Verify that webhook pods from cert-manager is ready
  shell: "kubectl get apiservice v1alpha1.certmanager.k8s.io -o jsonpath='{@.status.conditions[0].status}'"
  register: cmd_result
  until: cmd_result.stdout.find('True') != -1
  retries: 20
  delay: 60


- name: Create kubernetes secret which stores the master key and secret for decryption
  shell: kubectl create secret generic jenkins-secrets --namespace=jx --from-file=master.key --from-file=hudson.util.Secret
  args:
    chdir: "{{role_path}}/vars"
  --set spec.acme.email={{ user_email }}
```