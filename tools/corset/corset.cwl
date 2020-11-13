#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: "Corset is a command-line program to go from a de novo transcriptome assembly to gene-level counts."
doc: >
    "Corset is a command-line program to go from a de novo transcriptome assembly to gene-level counts. 
    Our software takes a set of reads that have been multi-mapped to the transcriptome (where multiple 
    alignments per read were reported) and hierarchically clusters the transcripts based on the proportion 
    of shared reads and expression patterns. It will report the clusters and gene-level counts for each sample, 
    which are easily tested for differential expression with count based tools such as edgeR and DESeq."

requirements:
  - class: InlineJavascriptRequirement

hints:
  - class: DockerRequirement
    dockerImageId: corset:1.0.9

baseCommand: [corset]

inputs:
  input_bam_files:
    label: "multi-mapped bam files"
    doc: > 
        "Can be single, paired-end, or mixed (not required to be indexed.
        To combine results from different transciptomes, you can include all
        in the list (on CLI: comma separated, through CWL: entries in array of files)"
    type: File[]
    inputBinding:
      position: 0
  
  distance_thresholds:
    label: "List of distance thresholds"
    doc: >
        "Range must be between 0 and 1 (0.4,0.5), if more than one distance threshold
        is given, the output filenames will be in the form: counts-<threshold>.txt and
        clusters-<thresholds>.txt"
    type: double
    default: 0.3
    inputBinding:
      position: 1
      prefix: -d
  
  log_likelihood_threshold:
    label: "Value used for thresholding log likelihood ratio"
    doc: >
        "Default value will depoend on number of degrees of freedom (number of groups -1)
        "