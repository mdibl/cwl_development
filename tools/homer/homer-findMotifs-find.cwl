cwlVersion: v1.0
class: CommandLineTool
label: "Homer (Hypergeometric Optimization of Motif EnRichment) is a suite of tools for Motif Discovery and ChIP-Seq analysis"
doc: >
    "Homer (Hypergeometric Optimization of Motif EnRichment) is a suite of tools for Motif Discovery and ChIP-Seq analysis. 
    It is a collection of command line programs for unix-style operating systems written in mostly perl and c++. 
    Homer was primarily written as a de novo motif discovery algorithm that is well suited for finding 8-12 bp 
    motifs in large scale genomics data."

requirements:
 - class: InlineJavascriptRequirement

hints:
 - class: DockerRequirement
   dockerPull: biowardrobe2/homer:v0.0.2

baseCommand: [ findMotifs.pl ]

inputs:
  input_list:
    label: "input list of genes"
    doc: "input list of genes"
    type: File
    inputBinding:
      position: 0
  
  promoter_set:
    label: "organism-specific promoter set"
    doc: "view available promoter sets with `perl configureHomer.pl -list`, initialize custo with loadPromoters.pl"
    type: string
    inputBinding:
      position: 1

  output_dir:
    label: "output directory"
    doc: "output directory"
    type: Directory
    inputBinding:
      position: 2
  
  find_motif_loc:
    doc: "Recover motif locations"
    type: File
    inputBinding:
      position: 3
      prefix: -find

  cpu:
    label: "number of cpu threads"
    doc: "number of cpu threads"
    type: int
    inputBinding:
      position: 4
      prefix: -p

outputs:
  findMotif-find_results:
    type:
      type: array
      items: [ File, Directory ]
    outputBinding:
      glob: "*"
    
  console_log:
    type: stdout
    
  error_log:
    type: stdout
    
stdout: "homer-findMotifs-find_console.txt"
stderr: "homer-findMotifs-find_error.txt"
