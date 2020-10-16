cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: comics/trinityrnaseq:2.2.0
    #dockerPull: trinityrnaseq/trinityrnaseq
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fq)

baseCommand: [Trinity, --full_cleanup]

inputs:
  seq_type: 
    type: string
    inputBinding:
      position: 1
      prefix: --seqType
  max_memory:
    type: string
    inputBinding:
      position: 2
      prefix: --max_memory
  fq:
    type: File
    inputBinding:
      position: 3
      prefix: --single
      valueFrom: $(self.basename)
  cpu:
    type: int?
    inputBinding:
      position: 4
      prefix: --CPU
  ss_lib_type:
    type: string?
    inputBinding:
      position: 5
      prefix: --SS_lib_type
  no_bowtie:
    type: boolean?
    inputBinding:
      position: 6
      prefix: --no_bowtie
  trimmomatic:
    type: boolean?
    inputBinding:
      position: 7
      prefix: --trimmomatic
  normalize_by_read_set:
    type: boolean?
    default: true
    inputBinding:
      position: 8
      prefix: --normalize_by_read_set
  output_dir:
    type: string
    inputBinding:
      position: 9
      prefix: --output

outputs:
  trinity_results:
    type: Directory
    outputBinding:
      glob: $(inputs.output_dir)
  assembled_contigs:
    label: Generated contigs
    type: File
    outputBinding:
      glob: "*fasta"
