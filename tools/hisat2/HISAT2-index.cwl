cwlVersion: v1.0
class: CommandLineTool
label: "The hisat2-build indexer"
doc: "The hisat2-build indexer: hisat2-build builds a HISAT2 index from a set of DNA sequences. https://ccb.jhu.edu/software/hisat2/manual.shtml#the-hisat2-build-indexer"

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/hisat2:2.1.0--py36h2d50403_1

baseCommand: [hisat2-build]

inputs:
  reference_fasta:
    label: "reference sequence(s) given on the command line"
    type: File[]
    inputBinding:
      position: 1
  index_basename:
    label: "string denoting the name of the index file being created"
    type: string
    inputBinding:
      position: 2

outputs:
  index_files:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*"

  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: hisat2_index_console.txt
stderr: hisat2_index_error.txt