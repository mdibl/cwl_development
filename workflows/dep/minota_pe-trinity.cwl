class: Workflow
cwlVersion: v1.0
id: minota_pe_trinity
label: minota_pe-trinity
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: right_reads
    type: File
    label: right read(s)
    description: |
      "right reads, one or more file names (separated by commas, no spaces)"
    'sbg:x': -473
    'sbg:y': -164
  - id: left_reads
    type: File
    label: left read(s)
    description: |
      "left reads, one or more file names (separated by commas, no spaces)"
    'sbg:x': -483
    'sbg:y': 21
  - id: database
    type: File
    label: BLAST database name
    description: ''
    'sbg:x': 213.79287719726562
    'sbg:y': -341.54437255859375
outputs:
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file
    description: ''
    'sbg:x': -115.9526596069336
    'sbg:y': -5.041419982910156
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    description: ''
    'sbg:x': 409.05914306640625
    'sbg:y': 81.53253936767578
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    description: ''
    'sbg:x': 438.45562744140625
    'sbg:y': -57.33135986328125
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    description: ''
    'sbg:x': 451.5621337890625
    'sbg:y': -166.37278747558594
  - id: blastp_output
    outputSource:
      - blastp_transdecoder_query/blastp_output
    type: File
    description: ''
    'sbg:x': 710.8342895507812
    'sbg:y': -366.69232177734375
steps:
  - id: trinity_pe
    in:
      - id: trimmomatic
        default: true
      - id: trinity_max_mem
        default: 50Gb
      - id: left_reads
        source: left_reads
      - id: right_reads
        source: right_reads
    out:
      - id: assembled_contigs
      - id: trans_map
      - id: timing_file
    run: ../../tools/trinity/trinity_pe.cwl
    label: Trinity assembles transcript sequences from Illumina RNA-Seq data.
    'sbg:x': -325.3726806640625
    'sbg:y': -74.75065612792969
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: geneToTranscriptMap
        source: trinity_pe/trans_map
      - id: transcriptsFile
        source: trinity_pe/assembled_contigs
    out:
      - id: workingDir
    run: ../../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames
    'sbg:x': -0.1715976893901825
    'sbg:y': -203.05325317382812
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: transcriptsFile
        source: trinity_pe/assembled_contigs
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: >-
      TransDecoder.Predict: Perl script, which predicts the likely coding
      regions
    'sbg:x': 239.4792938232422
    'sbg:y': -164.9408416748047
  - id: blastp_transdecoder_query
    in:
      - id: transdecoder_pep
        source: _trans_decoder__predict_v5/peptide_sequences
      - id: database
        source: database
    out:
      - id: blastp_output
    run: ../../tools/blastp/blastp_transdecoder_query.cwl
    'sbg:x': 467.8165588378906
    'sbg:y': -336.4082946777344
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
