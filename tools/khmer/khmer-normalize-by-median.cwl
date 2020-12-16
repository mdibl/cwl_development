cwlVersion: v1.0
class: CommandLineTool
label: "Do digital normalization (remove mostly redundant sequences"

requirements:
  - class: InlineJavascriptRequirement

hints:
  - class: DockerRequirement
    dockerImageId: khmer:2.1

baseCommand: [ normalize-by-median ]

inputs:
  input_sequence_filename:
    label: "Input FAST[AQ] sequence filename"
    type: File
    inputBinding:
      position: 0
  
  khmer_version:
    label: "show program version number and exit"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --version
  
  khmer_info:
    label: "print citation info"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --info
  
  kmer_size:
    label: "kmer size to use"
    type: int
    inputBinding:
      position: 0
      prefix: --ksize
  
  unique_kmers:
    label: "approximate number of unique kmers in the input set"
    type: int?
    inputBinding:
      position: 0
      prefix: --unique-kmers
  
  fp_rate:
    label: "override the automatic FP rate setting for the current script"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --fp-rate
  
  max_memory_usage:
    label: "maximum amount of memory to use for data structure"
    type: int
    inputBinding:
      position: 0
      prefix: --max-memory-usage
  
  small_count:
    label: "reduce memory usage by using a smaller counter for individual kmers"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --small-count
  
  quiet_mode:
    label: "quiet mode disabled/enabled"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --quiet
  
  read_cutoff:
    label: "when the median kmer coverage level is above this number, the read is not kept"
    type: int
    inputBinding:
      position: 0
      prefix: --cutoff
  
  paired_req:
    label: "require that all sequences be properly paired"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --paired
  
  force_single:
    label: "treat all sequences as single-end/unpaired"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --force_single
  
  unpaired_reads_filename:
    label: "include a file of unpaired reads to which -p/--paired does not apply"
    type: string?
    inputBinding:
      position: 0
      prefix: --unpaired-reads
  
  savegraph_filename:
    label: "save kmer count graph to disk after all reads are loaded"
    type: string?
    inputBinding:
      position: 0
      prefix: --savegraph
  
  report_filename:
    label: "write progress report to report_filename"
    type: string?
    inputBinding:
      position: 0
      prefix: --report
  
  report_frequency:
    label: "report progress every report_frequency reads"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --report-frequency
  
  force:
    label: "continue past file reading errors"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --force
  
  output_filename:
    label: "only output a single file with the specified filename"
    type: string
    inputBinding:
      position: 0
      prefix: --output

  loadgraph:
    label: "load a precomputed kmer graph from disk"
    type: string?
    inputBinding:
      position: 0
      prefix: --loadgraph
  
  gzip:
    label: "compress output using gzip"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --gzip
  
  bzip:
    label: "compress output using bzip"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --bzip

outputs:
