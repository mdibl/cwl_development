cwlVersion: v1.0
class: CommandLineTool
label: "A tool that conducts differential analysis between two biological samples"
doc: >
    "According to the central dogma of molecular biology, a pre-mRNA is synthesized from the coding sequence of a gene during the transcriptional process. 
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

baseCommand: [Diff_APA_site_analysis]

inputs:
  primary_condition:
    label: "Comma separated file names of condition 1 are given using this option"
    doc: "Each of these files is the APA site detection file, outputted by the first part of TAPAS (outputted by APA_sites_detection)"
    type: File[]
    inputBinding:
      position: 1
      prefix: -C1

  secondary_condition:
    label: "Comma separated file names of condition 2 are given using this option"
    doc: "Each of these files is the APA site detection file, outputted by the first part of TAPAS (outputted by APA_sites_detection)"
    type: File[]
    inputBinding:
      position: 2
      prefix: -C2

  annotation_file_name:
    label: "An annotation file is given using this option"
    doc: "e.g. Human annotation file is given in Finding_APA_Sites directory for reference"
    type: File
    inputBinding:
      position: 3
      prefix: -ref
  
  cutoff_value:
    label: "Cutoff value is given using this option"
    doc: "This parameter is explained in TAPAS manuscript. Default value: 70"
    type: int
    default: 70
    inputBinding:
      position: 4
      prefix: -cutoff
  
  differential_analysis_type:
    label: "Type of differential analysis"
    doc: "d -> differential APA site analysis, s -> shortening/lengthening event analysis"
    type: string
    inputBinding:
      position: 5
      prefix: -type
  
  output_file_name:
    label: "Output file name is given using this option"
    doc: "Default: for differential APA site analysis diff_result_final.txt, 
					for shortening/lengthening event analysis: decision_output.txt"
    type: string
    inputBinding:
      position: 6
      prefix: -o

outputs:
  tapas-analysis_result:
    type: File
    outputBinding:
      glob: $(inputs.output_file_name)
  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: "tapas-analysis_console.txt"
stderr: "tapas-analysis_error.txt"