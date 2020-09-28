cwlVersion: v1.0
class: CommandLineTool
label: "Assesses genome assembly and annotation completeness with single-copy orthologs"

hints:
  DockerRequirement:
    dockerPull: biocontainers/busco:4.0.6--pyr36_0

requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - $import BUSCO-assessment_modes.yaml

baseCommand: [ run_BUSCO.py ]

inputs:
  blastSingleCore:
    label: 'Force tblastn to run on a single core'
    doc: > 
        "Force tblastn to run on a single core and ignore the --cpu argument for
      this step only. Useful if inconsistencies when using multiple threads are
      noticed"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --blast_single_core
  cpu:
    label: 'Specify the number of threads/cores to use (default: 1)'
    type: int?
    inputBinding:
      position: 0
      prefix: --cpu
  evalue:
    label: 'E-value cutoff for BLAST searches'
    doc: >
        "Allowed formats: 0.001 or 1e-03 (default: 1e-03)"
    type: float?
    inputBinding:
      position: 0
      prefix: --evalue
  force:
    label: 'Force rewriting of existing files/folders'
    doc: >
        "Needs to be used when output files with the provided name already exist"
    type: boolean?
    inputBinding:
      position: 0
      prefix: --force
  help:
    label: 'Show this help message and exit'
    type: boolean?
    inputBinding:
      position: 0
      prefix: --help
  lineage:
    label: 'Location of the BUSCO lineage data to use (e.g. zebrafish_odb9)'
    doc: >
        "Specify location of the BUSCO lineage data to be used.
      Visit http://busco.ezlab.org/ for available lineages"
    type: Directory
    inputBinding:
      position: 0
      prefix: --lineage_path
  long_opt:
    label: 'Turn on Augustus optimization mode for self-training (default: Off)'
    doc: >
        "Adds substantially to the run time!
      Can improve results for some non-model organisms."
    type: boolean?
    inputBinding:
      position: 0
      prefix: --long
  mode:
    label: 'Sets the assessment MODE: genome, proteins, transcriptome'
    doc: >
        "Specify which BUSCO analysis mode to run.
      There are three valid modes:
      - geno or genome, for genome assemblies (DNA).
      - tran or transcriptome, for transcriptome assemblies (DNA).
      - prot or proteins, for annotated gene sets (protein)."
    type: BUSCO-assessment_modes.yaml#assessment_modes
    inputBinding:
      position: 0
      prefix: --mode
  outputName:
    label: 'Name to use for the run and all temporary files (appended)'
    doc: >
        "Give your analysis run a recognisable short name.
      Output folders and files will be labelled (prepended) with this name.
      WARNING: do not provide a path."
    type: string
    inputBinding:
      position: 0
      prefix: --out
  quiet:
    label: 'Disable the info logs, display only errors'
    type: boolean?
    inputBinding:
      position: 0
      prefix: --quiet
  regionLimit:
    label: 'How many candidate regions to consider (integer, default: 3)'
    doc: >
        "NB: this limit is on scaffolds, chromosomes, or transcripts, not
      individual hit regions."
    type: int?
    inputBinding:
      position: 0
      prefix: --limit
  restart:
    label: 'Restart the BUSCO run from the last successfully-completed step'
    doc: >
        "NB: If all the required results files from previous steps are not all
      found then this will not be possible."
    type: boolean?
    inputBinding:
      position: 0
      prefix: --restart
  sequenceFile:
    label: 'Sequence file in FASTA format'
    doc: >
        "Input sequence file in FASTA format (not compressed/zipped!).
      Can be an assembled genome (genome mode) or transcriptome (DNA,
      transcriptome mode), or protein sequences from an annotated gene set
      (proteins mode).
      NB: select just one transcript/protein per gene for your input,
      otherwise they will appear as 'Duplicated' matches."
    type: File
    inputBinding:
      position: 0
      prefix: --in
  species:
    label: 'Name of existing Augustus species gene finding parameters'
    doc: >
        "See Augustus documentation for available options.
      Each lineage has a default species (see below on assessment sets).
      Selecting a closely-related species usually produces better results."
    type: string?
    inputBinding:
      position: 0
      prefix: --species
  tarzip:
    label: 'Results folders with multiple files will be tarzipped'
    type: boolean?
    inputBinding:
      position: 0
      prefix: --tarzip
  tempPath:
    label: 'Where to store temporary files (default: ./tmp'
    type: Directory?
    inputBinding:
      position: 0
      prefix: --tmp
  version_opt:
    label: 'Show version info and exit'
    type: boolean?
    inputBinding:
      position: 0
      prefix: --version

outputs:
  blastOutput:
    doc: >
        "tBLASTN results, not created for assessment of proteins"
      File: tblastn_XXXX.txt = tabular tBLASTn results
      File: coordinates_XXXX.txt = locations of BUSCO matches (genome mode)
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/blast_output
  fullTable:
    doc: >
        "Contains the complete results in a tabular format with scores and lengths
      of BUSCO matches, and coordinates (for genome mode) or gene/protein IDs
      (for transcriptome or proteins mode)."
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/full_table_*.tsv
  hmmerOutput:
    label: 'Tabular format HMMER output of searches with BUSCO HMMs'
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/hmmer_output
  missingBUSCOs:
    label: 'Contains a list of missing BUSCOs'
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/missing_busco_list_*.tsv
  shortSummary:
    doc: >
        "Contains a plain text summary of results in BUSCO notation.
        Additionally provides brief metric breakdown"
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/short_summary_*.txt
  translatedProteins:
    label: 'Transcript sequence translations, only created during
            transcriptome assessment'
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/translated_proteins