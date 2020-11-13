class: CommandLineTool
cwlVersion: v1.0

baseCommand: [ busco ]

inputs:
  - id: sequenceFile
    type: File
    inputBinding:
      position: 0
      prefix: '--in'
    label: Sequence file in FASTA format
    doc: |
      Input sequence file in FASTA format (not compressed/zipped!).
      Can be an assembled genome (genome mode) or transcriptome (DNA,
      transcriptome mode), or protein sequences from an annotated gene set
      (proteins mode).
      NB: select just one transcript/protein per gene for your input,
      otherwise they will appear as 'Duplicated' matches.
  
  - id: lineage
    type: string
    inputBinding:
      position: 0
      prefix: '--lineage_dataset'
    label: Location of the BUSCO lineage data to use (e.g. fungi_odb10)
    doc: |
      Specify location of the BUSCO lineage data to be used.
      Visit http://busco.ezlab.org/ for available lineages.

 # - id: configFile
 #   type: File
 #   inputBinding:
 #     position: 0
 #     prefix: --config
  
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

  - id: mode
    type: BUSCO-assessment_modes.yaml#assessment_modes
    inputBinding:
      position: 0
      prefix: '--mode'
    label: 'Sets the assessment MODE: genome, proteins, transcriptome'
    doc: |
      Specify which BUSCO analysis mode to run.
      There are three valid modes:
      - geno or genome, for genome assemblies (DNA).
      - tran or transcriptome, for transcriptome assemblies (DNA).
      - prot or proteins, for annotated gene sets (protein).

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
doc: >
  BUSCO v4 provides quantitative measures for the assessment of genome assembly,
  gene set, and transcriptome completeness, based on evolutionarily-informed expectations
  of gene content from near-universal single-copy orthologs selected from OrthoDB v9.
  BUSCO assessments are implemented in open-source software, with a large
  selection of lineage-specific sets of Benchmarking Universal Single-Copy Orthologs. These
  conserved orthologs are ideal candidates for large-scale phylogenomics studies, and the
  annotated BUSCO gene models built during genome assessments provide a comprehensive gene
  predictor training set for use as part of genome annotation pipelines.

  Please visit http://busco.ezlab.org/ for full documentation.

  The BUSCO assessment software distribution is available from the public GitLab
  project:
  https://gitlab.com/ezlab/busco where it can be downloaded or cloned using a
  git client (git clone https://gitlab.com/ezlab/busco.git). We encourage users to opt for
  the git client option in order to facilitate future updates.

  BUSCO is written for Python 3.x and Python 2.7+. It runs with the standard
  packages. We recommend using Python3 when available.
label: >-
  Assesses genome assembly and annotation completeness with single-copy
  orthologs
requirements:
  - class: ResourceRequirement
    coresMin: 1
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - $import: BUSCO-assessment_modes.yaml
  #- class: InitialWorkDirRequirement
   # listing: $(inputs.configFile)
hints:
  - class: DockerRequirement
    dockerImageId: ezlabgva/busco:v4.1.3_cv1
    #dockerPull: 'quay.io/biocontainers/busco:4.0.6--pyr36_0'
  - class: gx:interface
    gx:inputs:
      - gx:name: blastSingleCore
        gx:type: boolean
        gx:optional: True
      - gx:name: cpu
        gx:type: integer
        gx:optional: True
      - gx:name: evalue
        gx:type: float
        gx:optional: True
      - gx:name: force
        gx:type: boolean
        gx:optional: True
      - gx:name: help
        gx:type: boolean
        gx:optional: True
      - gx:name: lineage
        gx:type: data
      - gx:name: long
        gx:type: boolean
        gx:optional: True
      - gx:name: mode
        gx:value: tran
        gx:type: text
      - gx:name: outputName
        gx:value: TEST
        gx:type: text
      - gx:name: quiet
        gx:type: boolean
        gx:optional: True
      - gx:name: regionLimit
        gx:type: integer
        gx:optional: True
      - gx:name: restart
        gx:type: boolean
        gx:optional: True
      - gx:name: sequenceFile
        gx:format: 'txt'
        gx:type: data
      - gx:name: species
        gx:type: text
        gx:optional: True
      - gx:name: tarzip
        gx:type: boolean
        gx:optional: True
      - gx:name: tempPath
        gx:type: data
        gx:optional: True
      - gx:name: version
        gx:type: boolean
        gx:optional: True
$schemas:
  - 'http://edamontology.org/EDAM_1.20.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"
s:author: "Arnaud Meng, Maxim Scheremetjew"
