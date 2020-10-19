cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/spades:3.14.0--h2d02072_0

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ spades.py ]

arguments:
  - prefix: -o
    valueFrom: $(runtime.outdir)

inputs:
  rna_mode:
    type: boolean
    inputBinding:
      prefix: --rna
  single_reads:
    type: File
    inputBinding:
      prefix: -s
  threads:
    type: int
    inputBinding:
      prefix: -t
  memory:
    type: int
    inputBinding:
      prefix: -m

outputs:
  transcript_file:
    type: File
    outputBinding:
      glob: "transcripts.fasta"
  