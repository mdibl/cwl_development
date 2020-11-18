cwlVersion: v1.0
class: CommandLineTool
doc: search sequence(s) against a profile database
hints:
  DockerRequirement:
    dockerImageId: hmmer:3.3.1
    dockerPull: comics/hmmer:latest
baseCommand: hmmscan

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.hmmdb_files)
  
inputs:
  hmmdb_files:
    type: File[]
  hmmdb_label:
    type: string
    inputBinding:
      position: 18
  seqfile:
    type: File
    inputBinding:
      position: 20
  cpu:
    type: int?
    inputBinding:
      position: 0
      prefix: --cpu
  output_prefix:
    type: string?
    default: hmmscan_out

arguments:
  - prefix: -o
    valueFrom: $(inputs.output_prefix + ".hmmscan.out.txt")
  - prefix: --domtblout
    valueFrom: $(inputs.output_prefix + ".hmmscan.dom.txt")
  - prefix: --tblout
    valueFrom: $(inputs.output_prefix + ".hmmscan.tbl.txt")


outputs:
  output_files:
    type: File[]
    outputBinding:
      glob: "*hmmscan.*.txt"
