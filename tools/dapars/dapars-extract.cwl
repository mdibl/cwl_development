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
<<<<<<< HEAD
=======
  InlineJavascriptRequirement: {}

hints:
>>>>>>> development
  DockerRequirement:
    dockerImageId: dapars:0.9.1
    #dockerOutputDirectory: /working_directory
  InlineJavascriptRequirement: {} 
  #InitialWorkDirRequirement:
   # listing:
    #- entry: $(inputs.working_directory)
     # writable: true
      #entryname: $("/working_directory")

baseCommand: [ DaPars_Extract_Anno ]

inputs:
<<<<<<< HEAD
  #working_directory:
   # type: Directory

=======
>>>>>>> development
  gene_bed_file:
    label: "The gene model in BED format, can be downloaded from UCSC"
    type: File
    inputBinding:
      position: 1
      prefix: -b
  
  gene_symbol_file:
    label: "The mapping of transcripts to gene symbol, which can be extracted from UCSC Tables with the following format"
    doc: "Please refer the example file hg19_4_19_2012_Refseq_id_from_UCSC.txt in the DaPars_Test_Dataset"
    type: File
    inputBinding:
      position: 2
      prefix: -s
  
  output_file:
    label: "The output prefix of the extracted annotation region will be used in the following configure file after “Annotated_3UTR”"
    type: string
    inputBinding:
      position: 3
      prefix: -o
  
outputs:
  dapars-extract_result:
    type: File
    outputBinding:
      glob: $(inputs.output_file)
  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: "dapars-extract_console.txt"
stderr: "dapars-extract_error.txt"
