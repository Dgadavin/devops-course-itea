job("clean-npm-cache") {
  wrappers {
      preBuildCleanup()
  }
  logRotator {
      numToKeep(1)
  }
  steps {
    def cmd = '''#!/bin/bash +x
    NODE_VERSION="v8.14.1"
    if [ ! -d "$WORKSPACE/node-$NODE_VERSION-linux-x64" ]; then
      wget https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
      tar xf node-$NODE_VERSION-linux-x64.tar.xz
    fi
    export PATH=$WORKSPACE/node-$NODE_VERSION-linux-x64/bin/:$PATH
    npm cache clean --force
    '''.stripIndent()

    shell(cmd)
  }
}
