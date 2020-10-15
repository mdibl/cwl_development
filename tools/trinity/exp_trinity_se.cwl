cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: comics/trinityrnaseq:2.2.0
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fq)
baseCommand: ["Trinity"]

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
  output_dir:
    type: string
    inputBinding:
      position: 8
      prefix: --output

outputs:
  trinity_results:
    type: Directory
    outputBinding:
      glob: $(inputs.output_dir)
  trinity_fasta:
    type: File
    outputBinding:
      glob: "Trinity.fasta"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:license: https://spdx.org/licenses/Apache-2.0
s:codeRepository: https://github.com/pitagora-network/pitagora-cwl

$schemas:
  - https://schema.org/docs/schema_org_rdfa.html
  - http://edamontology.org/EDAM_1.18.owl
