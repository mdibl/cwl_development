cwlVersion: v1.0
class: CommandLineTool
label: "A tool for detecting novel APA sites within a gene from RNA-seq Data"
doc: >
    "Accoring to the central dogma of molecular biology, a pre-mRNA is synthesized from the coding sequence of a gene during the transcriptional process. 
    This pre-mRNA is coverted into a (mature) mRNA by the post-transcriptional process. The post-transcriptional process consists of three major steps. 
    One of them is the addition of polyadenylation (polyA) tail using the polyadenylation pocess, which in turn consists of two substeps: 
    cleavage at the 3' end of the pre-mRNA and addition of a polyA tail at the cleavage site. But, due to the effect of certain cis-acting elements and 
    trans-acting factors, alternative cleavage sites can be formed from in a pre-mRNA. More precisely, a single pre-mRNA may often produce more than one 
    mRNA with 3' untranslated regions (3' UTRs) of different lengths. TAPAS is a tool for detecting such alternative (or all) polyadenylation (APA) sites 
    within a gene from RNA-Seq data. If two biological samples with multiple replicates are given, TAPAS can indentify differentially expressed APA sites 
    between the samples. Moreover, its differential analysis has been extended to discover the shortening/lengthening of 3' UTRs within a gene."

hints:
  DockerRequirement:
    dockerImageId: tapas:latest

baseCommand: [APA_sites_detection]

inputs:
  annotation_file_name:
    label: "An annotation file is given using this option"
    doc: "e.g. Human annotation file is given in Finding_APA_Sites directory for reference"
    type: File
    inputBinding:
      position: 1
      prefix: -ref
  
  coverage_file_name:
    label: "A read coverage file is provided using this option"
    doc: "Samtools is used to have the read coverage"
    type: File
    inputBinding:
      position: 2
      prefix: -cov
  
  read_length:
    label: "Read length"
    type: int
    inputBinding:
      position: 3
      prefix: -l
  
  output_file_name:
    label: "Output file name is given using this option"
    type: string
    inputBinding:
      position: 4
      prefix: -o
  
  penalty_value:
    label: "A penalty value can be provided using this option"
    doc: "If nothing is given, the value is determined from the read coverage of the 3' UTR frame"
    type: double?
    inputBinding:
      prefix: -p

outputs:
  tapas-detection_result:
    type: File
    outputBinding:
      glob: $(inputs.output_file_name)
  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: "tapas-detection_console.txt"
stderr: "tapas-detection_error.txt"