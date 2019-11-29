folder('Backend') {

}

def services = [
  "new-backend",
  "one-more-backend",
  "and-one-more-backend"
]
def credentialsToUse = "github-deploy"
def environment = System.getenv('ENV')

services.each {
  service = it
  println("${service}")
  pipelineJob("Backend/${service}") {
    	logRotator {
       		numToKeep(10)
    	}

    parameters {
      choiceParam('ACTION', ["apply", "plan"], "Choose current action")
      stringParam('COMMIT_HASH', '', 'use first 6 symbols from git commit hash')
      if (environment == "dev") {
        stringParam('BRANCH', 'develop')
      }
      else if (environment == "qa") {
        stringParam('BRANCH', 'release/1.0')
      }
      else if (environment == "stage") {
        stringParam('BRANCH', 'release/1.0')
      }
	    booleanParam('BUILD_IMAGE', true, 'Build image')
    }
    definition {
        cpsScm {
   			scm {
            	git {
                  remote {
                        url("git@git.github.com/dgadavin/${service}.git")
                        credentials(credentialsToUse)
                        branch("\${BRANCH}")
                  }
              }
        }
        scriptPath("Jenkinsfile")
      }

    }

 }

}
