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
def tflint(quality) {
  sh 'touch tflint.xml'
  sh 'tflint ./ -f checkstyle | tee -a  tflint.xml'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(id: 'tflint', name: 'TFLint', pattern: 'tflint.xml')]
  archiveArtifacts artifacts: 'tflint.xml', followSymlinks: false
  sh 'rm tflint.xml'
}

pipeline {
  agent any
  environment {
    QUALITY_TERRAFORM = "1"
    QUALITY_YAML = "1"
    QUALITY_SHELL = "1"
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
              image 'ysebastia/yamllint:1.30.0'
            }
          }
          steps {
            yamllint(QUALITY_YAML)
          }
        }
        stage ('tflint') {
            agent {
                docker {
                      image 'ysebastia/tflint:0.45.0'
                  }
          }
            steps {
                tflint(QUALITY_TERRAFORM)
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