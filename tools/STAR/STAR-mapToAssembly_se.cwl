cwlVersion: v1.0
class: CommandLineTool
label: "STAR mapping: running mapping jobs."
doc: "STAR: Spliced Transcripts Alignment to a Reference. https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf"

hints:
  DockerRequirement:
    dockerImageId: star:2.7.5
    dockerPull: quay.io/biocontainers/star:2.7.5c--0

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [STAR]

arguments:
  - prefix: --outFileNamePrefix
    valueFrom: $(inputs.output_dir_name)

inputs:
  output_dir_name:
    label: "Name of the directory to write output files in"
    doc: "Name of the directory to write output files in"
    type: string
    default: STAR
  nthreads:
    label: "Number of threads"
    doc: "defines the number of threads to be used for genome generation, it has to be set to the number of available cores on the server node."
    type: int
    inputBinding:
      prefix: --runThreadN
  genomeDir:
    label: "path to the directory where genome files are stored"
    doc: "path to the directory where genome files are stored"
    type: Directory
    inputBinding:
      prefix: --genomeDir
  outSAMtype:
    label: "type of SAM/BAM output"
    doc: "1st word: BAM: output BAM without sorting, SAM: output SAM without sorting, None: no SAM/BAM output, 2nd, 3rd: Unsorted: standard unsorted, SortedByCoordinate: sorted by coordinate. This option will allocate extra memory for sorting which can be specified by –limitBAMsortRAM"
    type: string[]
    default: ["BAM", "Unsorted"]
    inputBinding:
      prefix: --outSAMtype
  fq:
    label: "paths to files that contain input read"
    doc: "paths to files that contain input read1 (and, if needed, read2)"
    type: File[]
    inputBinding:
      prefix: --readFilesIn
      itemSeparator: ","

outputs:
  output_bam:
    type: File
    outputBinding:
      glob: "*am"
#  logfiles:
#    type: File[]
#    outputBinding:
#      glob: "*.log" 

#console_log:
    #type: stdout
  #error_log:
    #type: stderr

#stdout: star_mapping_se_console.txt
#stderr: star_mapping_se_error.txt