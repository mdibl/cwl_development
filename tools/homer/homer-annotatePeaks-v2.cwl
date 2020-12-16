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

baseCommand: [ annotatePeaks.pl ]

inputs:
  tss:
    doc: "Analyze transcription start sites as if they were peaks"
    type: boolean?
    inputBinding:
      position: 0
      prefix: tss
    
  genome:
    doc: "Genome version+organism to use"
    type: string
    inputBinding:
      position: 1
  
  hist_width:
    doc: |
      'Possible values:
        #"#" - performs analysis on the "#" bp surrounding the peak centers
        ##,#" - performs analysis from "#" to "#" relative to peak center
        #"given" - set size to actual coordinates in peak/BED file'
    type:
      #- int
      - string
    inputBinding:
      position: 2
      prefix: -size
    
  motif_density_hist:
    doc: "find histograms of motif density relative to the TSS"
    type: int?
    inputBinding:
      position: 3
      prefix: -hist
  
  motif_file:
    doc: "Motif file"
    type: File
    inputBinding:
      position: 4
      prefix: -m

  threads:
    type: int?
    inputBinding:
      position: 5
      prefix: -cpu
    doc: |
      "Set the number of threads. Default: 1"

  histogram_filename:
    type: string
    doc: "Output histogram's filename"

outputs:
  histogram_file:
    type: stdout
    doc: "Output histogram file"
  
  console_log:
    type: stdout
    
  error_log:
    type: stdout
    
#stdout: "homer-findMotifs-find_console.txt"
stderr: "homer-annotatePeaks-v2_error.txt"

stdout: ${return inputs.histogram_filename;}
  

