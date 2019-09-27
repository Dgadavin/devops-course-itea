pipelineJob("test-pipeline") {
    	logRotator {
       		numToKeep(10)
    	}

    parameters {
      choiceParam('ACTION', ["plan", "apply"], "Choose current action")
      stringParam('COMMIT_HASH')
	  booleanParam('BUILD_IMAGE', true, 'Build image')
    }

    definition {
        cpsScm {
   			scm {
            	git {
                  remote {
                        github("dgadavin/devops-course-itea", 'https')
                        branch("master")
                  }
              }
        }
        scriptPath("jenkins/Jenkinsfile")
      }

    }

 }
