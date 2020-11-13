#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: "Corset is a command-line program to go from a de novo transcriptome assembly to gene-level counts."
#doc: >
#    "Corset is a command-line program to go from a de novo transcriptome assembly to gene-level counts. 
#    Our software takes a set of reads that have been multi-mapped to the transcriptome (where multiple 
#    alignments per read were reported) and hierarchically clusters the transcripts based on the proportion 
#    of shared reads and expression patterns. It will report the clusters and gene-level counts for each sample, 
#    which are easily tested for differential expression with count based tools such as edgeR and DESeq."

requirements:
  - class: InlineJavascriptRequirement

hints:
  - class: DockerRequirement
    dockerImageId: corset:1.0.9

baseCommand: [corset]

inputs:
  input_bam_files:
    label: "multi-mapped bam files"
#    doc: > 
#        "Can be single, paired-end, or mixed (not required to be indexed.
#        To combine results from different transciptomes, you can include all
#        in the list (on CLI: comma separated, through CWL: entries in array of files)"
    type: File[]
    inputBinding:
      position: 0
  
  distance_thresholds:
    label: "List of distance thresholds"
#    doc: >
#        "Range must be between 0 and 1 (0.4,0.5), if more than one distance threshold
#        is given, the output filenames will be in the form: counts-<threshold>.txt and
#        clusters-<thresholds>.txt"
    type: double
    default: 0.3
    inputBinding:
      position: 1
      prefix: -d
  
  log_likelihood_threshold:
    label: "Value used for thresholding log likelihood ratio"
#    doc: >
#        "Default value will depoend on number of degrees of freedom (number of groups -1)
#        By default D = 17.5 + 2.5 *ndf, corresponds approximately to p-val threshold of 
#        10^-5, when there are fewer than 10 groups"
    type: double?
    inputBinding:
      position: 2
      prefix: -D
  
  transcript_filter:
    label: "Filter out transcripts with fewer than this many reads aligning"
    type: int
    default: 10
    inputBinding:
      position: 3
      prefix: -m
  
  #grouping_specification:
    #label: "Specifies which samples belong to which experimental groups"
    #doc: >
      #"The parameter must be a comma separated list (no spaces), with the
	    #groupings given in the same order as the bam filename. For example:
	    #-g Group1,Group1,Group2,Group2 etc. If this option is not used, each sample
	    #is treated as an independent experimental group"
    #type: string?
    #inputBinding:
      #position: 4
      #prefix: -g
  
  output_prefix:
    label: "Prefix for output filenames"
#    doc: >
#        "The output files will be of the form
#	      <prefix>-counts.txt and <prefix>-clusters.txt. Default filenames are:
#	      counts.txt and clusters.txt"
    type: string
    inputBinding:
      position: 5
      prefix: -p
  
  overwrite_files:
    label: "Specifies whether the output files should be overwritten if they already exist"
    type: boolean
    default: false
    inputBinding:
      position: 6
      prefix: -f
  
  header_name:
    label: "Specifies the sample names to be used in the header of the output count file"
#    doc: >
#      "This should be a comma separated list without spaces.
#	    e.g. -n Group1-ReplicateA,Group1-ReplicateB,Group2-ReplicateA etc.
#	    Default: the input filenames will be used."
    type: string?
    inputBinding:
      position: 7
      prefix: -n
  
  summarize_read_alignments:
    label: "Output a file summarising the read alignments"
#   doc: >
#      "This may be used if you
#	    would like to read the bam files and run the clustering in seperate runs
#	    of corset. e.g. to read input bam files in parallel. The output will be the
#	    bam filename appended with .corset-reads.
#	    Default: false"
    type: boolean
    default: false
    inputBinding:
      position: 8
      prefix: -r
  
  input_filetype:
    label: "The input file type"
    doc: >
#      "Use -i corset, if you previously ran
#	    corset with the -r option and would like to restart using those
#	    read summary files. Use salmon_eq_classes, if you aligned with salmon with
#	    the flag --dumpEq and are passing corset the equivalent class files.
#	    Running with either -i corset or salmon_eq_classes will switch off the -r option.
#	    Default: bam"
    type: string
    default: bam
    inputBinding:
      position: 9
      prefix: -i
  
  link_contig_filter:
    label: "If running with -i corset or salmon_eq_classes, this will filter out a link between contigs"
#   doc: >
#      "if the link is supported by less than this many reads. Default: 1 (no filtering)"
    type: int
    default: 1
    inputBinding:
      position: 10
      prefix: -l
  
  filter_reads:
#    doc: >
#      "If running with -i corset or salmon_eq_classes, this option will filter out reads that
#	    align to more than x contigs. Default: no filtering"
    type: int?
    inputBinding:
      position: 11
      prefix: -x

outputs:
  counts_file:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix)-counts.txt
  clusters_file:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix)-clusters.txt



