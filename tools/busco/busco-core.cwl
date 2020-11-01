class: CommandLineTool
cwlVersion: v1.0

hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/busco:4.0.6--pyr36_0'
    #dockerPull: 'ezlabgva/busco:v5.beta.1_cv1'

requirements:
  - class: ResourceRequirement
    coresMin: 1
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - $import: BUSCO-assessment_modes.yaml

baseCommand: [ busco ]

inputs:
  - id: configFile
    type: File
    inputBinding:
      position: 0
      prefix: --config
  
  - id: outputName
    type: string
    inputBinding:
      position: 0
      prefix: '--out'
    label: Name to use for the run and all temporary files (appended)
    doc: |
      Give your analysis run a recognisable short name.
      Output folders and files will be labelled (prepended) with this name.
      WARNING: do not provide a path.

outputs: 
  - id: blastOutput
    doc: |
      tBLASTn results, not created for assessment of proteins.
      File: tblastn_XXXX.txt = tabular tBLASTn results
      File: coordinates_XXXX.txt = locations of BUSCO matches (genome mode)
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/blast_output
  - id: fullTable
    doc: >
      Contains the complete results in a tabular format with scores and lengths
      of BUSCO matches, and coordinates (for genome mode) or gene/protein IDs
      (for transcriptome or proteins mode).
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/full_table_*.tsv
    format: 'iana:text/tab-separated-values'
  - id: hmmerOutput
    label: Tabular format HMMER output of searches with BUSCO HMMs
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/hmmer_output
  - id: missingBUSCOs
    label: Contains a list of missing BUSCOs
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/missing_busco_list_*.tsv
    format: 'iana:text/tab-separated-values'
  - id: shortSummary
    doc: |
      Contains a plain text summary of the results in BUSCO notation.
      Also gives a brief breakdown of the metrics.
    type: File
    outputBinding:
      glob: run_$(inputs.outputName)/short_summary_*.txt
  - id: translatedProteins
    label: >-
      Transcript sequence translations, only created during transcriptome
      assessment
    type: Directory
    outputBinding:
      glob: run_$(inputs.outputName)/translated_proteins