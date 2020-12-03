cwlVersion: v1.0
class: CommandLineTool
label: "STAR genomeGenerate: Generating genome indexes."
doc: >
    "STAR: Spliced Transcripts Alignment to a Reference. https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf"

hints:
  DockerRequirement:
    #dockerImageId: star:2.7.5
    dockerPull: quay.io/biocontainers/star:2.7.5c--0

baseCommand: [ STAR ]

arguments:
  - valueFrom: "--runMode genomeGenerate"
    position: -1

inputs:
  genomeFastaFiles:
    label: "Paths to genome fasta files"
    doc: >
        "specified one or more FASTA files with the genome reference sequences. 
        Multiple reference sequences (henceforth called chromosomes) are allowed for each fasta file. 
        You can rename the chromosomes names in the chrName.txt keeping the order of the chromo- somes 
        in the file: the names from this file will be used in all output alignment files (such as .sam). 
        The tabs are not allowed in chromosomes names, and spaces are not recommended."
    type: File[]
    inputBinding:
      prefix: --genomeFastaFiles

  IndexName:
    label: "Name of index"
    type: string
    inputBinding:
      prefix: --genomeDir
      valueFrom: ./$(self)

  sjdbGTFfile:
    label: "Path to annotation gtf file"
    doc: >
        "specifies the path to the file with annotated transcripts in the standard GTF format. 
        STAR will extract splice junctions from this file and use them to greatly improve accuracy of the mapping. 
        While this is optional, and STAR can be run without annotations, using annotations is highly recommended 
        whenever they are available. Starting from 2.4.1a, the annotations can also be included on the fly at the mapping step."
    type: File?
    inputBinding:
      prefix: --sjdbGTFfile

  sjdbOverhang:
    label: "ReadLength-1, a value to be used for spliced junction database construction"
    doc: >
        "specifies the length of the genomic sequence around the annotated junction to be used in 
        constructing the splice junctions database. Ideally, this length should be equal to the ReadLength-1, 
        where ReadLength is the length of the reads. For instance, for Illumina 2x100b paired-end reads, the 
        ideal value is 100-1=99. In case of reads of varying length, the ideal value is max(ReadLength)-1. 
        In most cases, the default value of 100 will work as well as the ideal value"
    type: int?
    default: 100
    inputBinding:
      prefix: --sjdbOverhang
  
  Junctions:
    label: "path to the file with genomic coordinates"
    doc: >
        "path to the files with genomic coordinates (chr <tab> start <tab>
        end <tab> strand) for the splice junction introns. Multiple files can be
        supplied wand will be concatenated."
    type: File?
    inputBinding:
      prefix: --sjdbFileChrStartEnd
  
  GenomeSize:
    label: "length (bases) of the SA pre-indexing string"
    doc: >
        "Typically between 10 and 15.
        Longer strings will use much more memory, but allow faster searches. For small
        genomes, the parameter –genomeSAindexNbases must be scaled down to
        min(14, log2(GenomeLength)/2 - 1)"
    type: int?
    inputBinding:
      prefix: --genomeSAindexNbases

  GenomeBits:
    label: "int: =log2(chrBin), where chrBin is the size of the bins for genome storage"
    doc: >
        "each chromosome will occupy an integer number of bins. For a genome with
        large number of contigs, it is recommended to scale this parameter as min(18,
        log2[max(GenomeLength/NumberOfReferences,ReadLength)])"
    type: int?
    inputBinding:
      prefix: --genomeChrBinNbits

  nthreads:
    default: 8
    label: "Number of threads"
    doc: >
        "defines the number of threads to be used for genome generation, it has
        to be set to the number of available cores on the server node."
    type: int
    inputBinding:
      prefix: --runThreadN

outputs:
  starIndex:
    type: Directory
    outputBinding:
      glob: ./$(inputs.IndexName)/

  console_log:
    type: stdout

  error_log:
    type: stderr

stdout: (inputs.IndexName).console.txt
stderr: (inputs.IndexName).error.txt