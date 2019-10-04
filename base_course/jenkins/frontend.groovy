folder('Frontend') {

}

def credentialsToUse = "github-deploy"

def services = [
  "repo1",
  "repo2"
]

services.each {
  service = it
  job("Frontend/${service}") {
    parameters {
      stringParam('BRANCH', "dev")
    }
    parameters {
      stringParam('ENVIRONMENT', "${environment}")
    }
    scm {
      git {
        remote {
            url("/${service}.git")
            credentials(credentialsToUse)
            branch('$BRANCH')
        }
      }
    }
    wrappers {
      preBuildCleanup()
    }

    steps {
      def command = '''#!/bin/bash +x
      echo "checking if node and npm package are already downloaded"
      NODE_VERSION="v10.11.0"
      if [ ! -d "$WORKSPACE/node-$NODE_VERSION-linux-x64" ]; then
        wget https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
        tar xf node-$NODE_VERSION-linux-x64.tar.xz
      fi
      export PATH=$WORKSPACE/node-$NODE_VERSION-linux-x64/bin/:$PATH
      NODE_ENV=$ENVIRONMENT
      echo "============="
      npm --version
      node --version
      echo "============="
      '''.stripIndent()

      shell(command)
    }
    if (environment == "dev") {
      steps {
        def command = '''#!/bin/bash +x
        echo "checking if node and npm package are already downloaded"
        NODE_VERSION="v9.11.0"
        if [ ! -d "$WORKSPACE/node-$NODE_VERSION-linux-x64" ]; then
          wget https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
          tar xf node-$NODE_VERSION-linux-x64.tar.xz
        fi
        export PATH=$WORKSPACE/node-$NODE_VERSION-linux-x64/bin/:$PATH
        NODE_ENV=$ENVIRONMENT
        echo "============="
        npm --version
        node --version
        echo "============="
        '''.stripIndent()

        shell(command)
      }
  }
  }
}
