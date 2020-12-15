cwlVersion: v1.0
class: CommandLineTool
label: "rsem-calculate-expression: calculate expression values (BAM input version CWL)"
doc: "RSEM is a software package for estimating gene and isoform expression levels from RNA-Seq data. The RSEM package provides an user-friendly interface, supports threads for parallel computation of the EM algorithm, single-end and paired-end read data, quality scores, variable-length reads and RSPD estimation. In addition, it provides posterior mean and 95% credibility interval estimates for expression levels.  http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html"

hints:
  DockerRequirement:
    dockerPull: reddylab/rsem:1.2.25

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsem-calculate-expression, --star]

inputs:
  nthreads:
    label: "Number of threads to use"
    doc: "Number of threads to use. Both Bowtie/Bowtie2, expression estimation and 'samtools sort' will use this many threads. (Default: 1)"
    type: int
    inputBinding:
      prefix: --num-threads
      position: 6
  paired-end:
    type: boolean
    default: true
    inputBinding:
      position: 0
      prefix: --paired-end
  input_fastq_fw:
    label: "Upstream reads for paired-end data"
    doc: "Upstream reads for paired-end data. By default, these files are assumed to be in FASTQ format."
    type: File
    inputBinding:
      position: 1
  input_fastq_rv:
    label: "Downstream reads for paired-end data"
    doc: "Downstream reads for paired-end data. By default, these files are assumed to be in FASTQ format."
    type: File
    inputBinding:
      position: 2
  reference_prefix:
    label: "The name of RSEM index files"
    doc: "The name of RSEM index files"
    type: string
    inputBinding:
      position: 3
      valueFrom: $(inputs.reference_files.path + "/" + self)
  reference_files:
    label: "Directory containing <reference_name>.seq, etc"
    type: Directory
  rsem_output_prefix:
    label: "The name of the sample analyzed"
    doc: "The name of the sample analyzed. All output files are prefixed by this name (e.g., sample_name.genes.results)"
    type: string
    inputBinding:
      position: 4
  star_path:
    label: "Path to local installation of STAR"
    type: Directory
    inputBinding:
      position: 5

outputs:
  genes:
    type: File
    outputBinding:
      glob: $(inputs.rsem_output_prefix + ".genes.results")
  isoforms:
    type: File
    outputBinding:
      glob: $(inputs.rsem_output_prefix + ".isoforms.results")
  stat:
    type:
      - 'null'
      - {type: array, items: File}
    outputBinding:
      glob: $(inputs.sample_name + ".stat/*")

  #console_log:
    #type: stdout  
  #error_log:
    #type: stderr

#stdout: $(inputs.rsem_output_prefix.basename + "_rsem-calc-exp_pe_console.txt")
#stderr: $(inputs.rsem_output_prefix.basename + "_rsem-calc-exp_pe_error.txt")
