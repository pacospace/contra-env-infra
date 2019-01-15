

### Delete all resources

```
oc delete all -l template=tf-jenkins-persistent
oc delete sa tf-jenkins
oc delete rolebinding tf-jenkins_edit
oc delete pvc tf-jenkins
```

