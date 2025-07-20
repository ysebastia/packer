def checkov() {
  sh 'checkov --soft-fail --directory . -o junitxml --output-file-path build/checkov --skip-download'
  recordIssues enabledForFailure: true, tools: [junitParser(id: 'checkov', name: 'Checkov', pattern: 'build/checkov/results_junitxml.xml')]
  archiveArtifacts artifacts: 'build/checkov/results_junitxml.xml', followSymlinks: false
  sh 'rm build/checkov/results_junitxml.xml'    
}
def cloc() {
  sh 'cloc --by-file --xml --fullpath --not-match-d="(build|vendor)" --out=cloc.xml ./'
  sloccountPublish encoding: '', pattern: 'cloc.xml'
  archiveArtifacts artifacts: 'cloc.xml', followSymlinks: false
  sh 'rm cloc.xml'
}
def yamllint(quality) {
  sh 'touch yamllint.txt'
  sh 'yamllint -f parsable . | tee -a yamllint.txt'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [yamlLint(id: 'yamlLint', name: 'Yaml Lint', pattern: 'yamllint.txt')]
  archiveArtifacts artifacts: 'yamllint.txt', followSymlinks: false
  sh 'rm yamllint.txt'
}
def shellcheck(quality) {
  sh 'touch shellcheck.xml'
  sh '/usr/local/bin/shellcheck.bash | tee -a shellcheck.xml'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(id: 'shellcheck', name: 'Shellcheck', pattern: 'shellcheck.xml')]
  archiveArtifacts artifacts: 'shellcheck.xml', followSymlinks: false
  sh 'rm shellcheck.xml'
}
def tflint(quality) {
  sh 'touch tflint.xml'
  sh 'tflint --recursive --format=checkstyle | tee -a  tflint.xml'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(id: 'tflint', name: 'TFLint', pattern: 'tflint.xml')]
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
        stage ('checkov') {
          agent {
            docker {
              image 'ysebastia/checkov:3.2.413'
            }
          }
          steps {
            checkov()
          }
        }
        stage ('Cloc') {
          agent {
            docker {
              image 'ysebastia/cloc:2.06'
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
              image 'ysebastia/shellcheck:0.9.0-r2'
            }
          }
          steps {
            shellcheck(QUALITY_SHELL)
          }
        }
        stage ('yamllint') {
          agent {
            docker {
              image 'ysebastia/yamllint:1.37.1'
            }
          }
          steps {
            yamllint(QUALITY_YAML)
          }
        }
        stage ('tflint') {
            agent {
                docker {
                      image 'ysebastia/tflint:0.58.1'
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
