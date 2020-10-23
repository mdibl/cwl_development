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
    'sbg:x': -563
    'sbg:y': -277
  - id: left_reads
    type: File
    label: left read(s)
    description: |
      "left reads, one or more file names (separated by commas, no spaces)"
    'sbg:x': -566
    'sbg:y': -36
outputs:
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file
    description: ''
    'sbg:x': -209
    'sbg:y': -109
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    description: Output cluster mapping file
    'sbg:x': -48
    'sbg:y': 97
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    description: Output fasta format file
    'sbg:x': -53
    'sbg:y': -59
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    description: ''
    'sbg:x': 384
    'sbg:y': -476
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    description: ''
    'sbg:x': 392
    'sbg:y': -367
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    description: ''
    'sbg:x': 399
    'sbg:y': -245
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    description: ''
    'sbg:x': 396
    'sbg:y': -133
steps:
  - id: trinity_pe
    in:
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
    'sbg:x': -402
    'sbg:y': -161
  - id: cd_hit_est
    in:
      - id: input
        source: trinity_pe/assembled_contigs
    out:
      - id: outClstr
      - id: outSeq
    run: ../../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': -171
    'sbg:y': 14
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
    'sbg:x': -15
    'sbg:y': -255
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
    'sbg:x': 193
    'sbg:y': -343
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
