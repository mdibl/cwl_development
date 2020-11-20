cwlVersion: v1.0
class: CommandLineTool
label: "CD-HIT-est"
doc: >
    "cluster nucleotide sequences
    use max available cpus and memory
    >cdhit-est -n 9 -d 0 -T 0 -M 0 -c 0.97 -i <input> -o <output>"

hints:
  DockerRequirement:
      dockerImageId: cdhit:4.8.1
      dockerPull: mgrast/pipeline:4.03

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ cd-hit-est ]

arguments:
  - prefix: -M
    valueFrom: "0"
  - prefix: -T
    valueFrom: "0"
  - prefix: -d
    valueFrom: "0"

inputs:
  input:
    doc: "Input fasta format file"
    type: File
    inputBinding:
      prefix: -i
    
  identity:
    doc: "Percent identity threshold, default 0.97"
    type: float?
    default: 0.97
    inputBinding:
      prefix: -c
    
  word:
    doc: "Word length, default 9"
    type: int?
    default: 9
    inputBinding:
      prefix: -n
    
  output_prefix:
    doc: "Output name"
    type: string
    inputBinding:
      prefix: -o

outputs: 
  outSeq:
    doc: "Output fasta format file"
    type: File
    outputBinding: 
      glob: $(inputs.output_prefix)
  outClstr:
    doc: "Output cluster mapping file"
    type: File
    outputBinding: 
      glob: $(inputs.output_prefix).clstr

#stdout: $(inputs.output_prefix + ".cd-hit-est.console.txt")
#stderr: $(inputs.output_prefix + ".cd-hit-est.error.txt")
