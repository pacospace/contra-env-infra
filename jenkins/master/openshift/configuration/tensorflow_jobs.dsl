single_Build_job = "tensorflow-build-s2i-single"
build_job = "tensorflow-build-s2i"

pipelineJob(single_Build_job) {
  properties {
    githubProjectUrl('https://github.com/tensorflow/tensorflow/')
  }
  parameters {
    stringParam("BAZEL_VERSION", "", "Version of Bazel for Tensorflow")
    stringParam("CUSTOM_BUILD", "", "Custom build command for Tensorflow")
    stringParam("OPERATING_SYSTEM", "", "Which Operating System is the job being built for")
    stringParam("PYTHON_VERSION", "", "Version of Python to be used in the job")
    stringParam("S2I_IMAGE", "", "Source 2 Image base image")
    stringParam("TF_GIT_BRANCH", "", "Tensorflow branch used when checking out code")
  }
  definition {
    cpsScm {
      scm {
        git {
          remote { url("https://github.com/thoth-station/tensorflow-build-s2i") }
          branch("*/master")
          extensions { }
        }
      }
    }
  }
}

pipelineJob(single_Build_job) {
  properties {
    githubProjectUrl('https://github.com/tensorflow/tensorflow/')
  }
  triggers {
    genericTrigger {
      genericVariables {
        genericVariable {
          key("release_version")
          value("\$.release.tag_name")
          expressionType("JSONPath")
        }
      }
      genericHeaderVariables {
        genericHeaderVariable {
          key("X-GitHub-Event")
        }
      }
      token('')
      regexpFilterText("\$x_github_event")
      regexpFilterExpression("^release$")
    }
  }
  definition {
    cpsScm {
      scm {
        git {
          remote { url("https://github.com/thoth-station/tensorflow-build-s2i") }
          branch("*/master")
          extensions { }
        }
      }
      scriptPath("JenkinsfileTrigger")
    }
  }
}

queue(single_job)
queue(build_job)
