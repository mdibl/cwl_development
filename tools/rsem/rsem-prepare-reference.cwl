cwlVersion: v1.0
class: CommandLineTool
label: "rsem-prepare-reference: preparing reference sequences"
doc: "RSEM is a software package for estimating gene and isoform expression levels from RNA-Seq data. The RSEM package provides an user-friendly interface, supports threads for parallel computation of the EM algorithm, single-end and paired-end read data, quality scores, variable-length reads and RSPD estimation. In addition, it provides posterior mean and 95% credibility interval estimates for expression levels.  http://deweylab.github.io/RSEM/rsem-prepare-reference.html"

hints:
  DockerRequirement:
    dockerPull: reddylab/rsem:1.2.25

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsem-prepare-reference]

arguments:
  - valueFrom: $(runtime.outdir)/$(inputs.reference_name)
    position: 50

inputs:
  nthreads:
    label: "Number of threads to use"
    doc: "Number of threads to use. Both Bowtie/Bowtie2, expression estimation and 'samtools sort' will use this many threads. (Default: 1)"
    type: int
    inputBinding:
      prefix: --num-threads
      position: 0
  gtf:
    label: "extract transcript reference sequences using the gene annotations specified in <file>"
    doc: "If this option is on, RSEM assumes that 'reference_fasta_file(s)' contains the sequence of a genome, and will extract transcript reference sequences using the gene annotations specified in <file>, which should be in GTF format."
    type: File
    inputBinding:
      prefix: --gtf
  reference_fasta_files:
    label: "A path to directory contains reference fasta files"
    doc: "Either a comma-separated list of Multi-FASTA formatted files OR a directory name. If a directory name is specified, RSEM will read all files with suffix '.fa' or '.fasta' in this directory. The files should contain either the sequences of transcripts or an entire genome, depending on whether the '--gtf' option is used."
    type: File
    inputBinding:
      position: 2
  reference_name:
    label: "The name of the reference used"
    doc: "The name of the reference used. RSEM will generate several reference-related files that are prefixed by this name. This name can contain path information (e.g. '/ref/mm9')."
    type: string
  star:
    label: "build STAR indices"
    type: boolean?
    default: false
    inputBinding:
      position: 0
      prefix: --star
  star_path:
    label: "Path to local installation of STAR"
    type: Directory
    inputBinding:
      position: 1
      prefix: --star-path

outputs:
  rsem_index:
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.reference_name + "*")
  starIndex:
    type: Directory
    outputBinding:
      glob: ./ref/
  #console_log:
    #type: stdout
  #error_log:
    #type: stderr

#stdout: rsem-index_console.txt
#stderr: rsem-index_error.txt
