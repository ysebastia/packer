def cloc() {
  sh 'cloc --by-file --xml --fullpath --not-match-d="(build|vendor)" --out=cloc.xml ./'
  sloccountPublish encoding: '', pattern: 'cloc.xml'
  archiveArtifacts artifacts: 'cloc.xml', followSymlinks: false
  sh 'rm cloc.xml'
}
def yamllint(quality) {
  sh 'touch yamllint.txt'
  sh 'yamllint -f parsable . | tee -a yamllint.txt'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [yamlLint(id: 'yamlLint', name: 'Yaml Lint', pattern: 'yamllint.txt')]
  archiveArtifacts artifacts: 'yamllint.txt', followSymlinks: false
  sh 'rm yamllint.txt'
}
def shellcheck(quality) {
  sh 'touch shellcheck.xml'
  sh '/usr/local/bin/shellcheck.bash | tee -a shellcheck.xml'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(id: 'shellcheck', name: 'Shellcheck', pattern: 'shellcheck.xml')]
  archiveArtifacts artifacts: 'shellcheck.xml', followSymlinks: false
  sh 'rm shellcheck.xml'
}

pipeline {
  agent any
  environment {
    QUALITY_YAML = "1"
    QUALITY_SHELL = "86"
  }
  stages {
    stage('QA') {
      parallel {
        stage ('Cloc') {
          agent {
            docker {
              image 'ysebastia/cloc:1.96'
            }
          }
          steps {
              mineRepository()
              cloc()
          }
        }
        stage ('shellcheck') {
          agent {
            docker {
              image 'ysebastia/shellcheck:0.9.0-2'
            }
          }
          steps {
            shellcheck(QUALITY_SHELL)
          }
        }
        stage ('Yaml lint') {
          agent {
            docker {
              image 'ysebastia/yamllint:1.29.0-1'
            }
          }
          steps {
            yamllint(QUALITY_YAML)
          }
        }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
