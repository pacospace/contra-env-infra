import jenkins.model.Jenkins
import org.jenkins.plugins.lockableresources.LockableResource
import org.jenkins.plugins.lockableresources.LockableResourcesManager

List resources = []

(1..3).each { it ->
  resources << new LockableResource("tensorflow_jobs_${it}", "", "tensorflow_jobs", "")
}

Jenkins j = Jenkins.instance
LockableResourcesManager resourceManager = j.getExtensionList(LockableResourcesManager.class)[0]

if(resourceManager.resources != resources) {
  resourceManager.resources = resources
  resourceManager.save()
  println "Configured lockable resources: ${resources*.name.join(', ')}"
} else {
  println 'Nothing changed.  Lockable resources already configured.'
}
