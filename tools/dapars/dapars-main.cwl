cwlVersion: v1.2.0-dev4
class: CommandLineTool
label: "Given the annotated gene model, DaPars can infer the de novo proximal APA sites as well as the long and short 
     3’UTR expression levels"
doc: >
    "The dynamic usage of the 3’untranslated region (3’UTR) resulting from alternative polyadenylation (APA)
     is emerging as a pervasive mechanism for regulating mRNA diversity, stability and translation. Though 
     RNA-seq provides the whole-transcriptome information and a lot of tools for analyzing gene/isoform expression 
     are available, very few tool focus on the analysis of 3’UTR from standard RNA-seq. DaPars is the first de novo 
     tool that directly infers the dynamic alternative polyadenylation (APA) usage by comparing standard RNA-seq. 
     Given the annotated gene model, DaPars can infer the de novo proximal APA sites as well as the long and short 
     3’UTR expression levels. Finally, the dynamic APA usages between two conditions will be identified."

requirements:
  DockerRequirement:
    dockerImageId: dapars:0.9.1
  InlineJavascriptRequirement: {}

baseCommand: [DaPars_main]

inputs:
  configure_file:
    label: Output of DaPars_Extract
    doc: Only parameter for DaPars_main, stores all parameters
    inputBinding:
      position: 1

outputs:
  dapars-main_result:
    type: File
    outputBinding:
      glob: $(inputs.configure_file)
  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: "dapars-main_console.txt"
stderr: "dapars-main_error.txt"