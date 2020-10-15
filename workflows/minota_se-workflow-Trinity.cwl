class: Workflow
cwlVersion: v1.0
id: minota_se_workflow
label: minota_se-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: outName
    type: string
    'sbg:x': 83
    'sbg:y': -22
  - id: single_reads
    type: File
    label: Single read(s)
    description: >
      "single reads, one or more file names, comma-delimited (note, if single
      file contains pairs, can use flag: --run_as_paired)"
    'sbg:x': -535.7160034179688
    'sbg:y': -19
outputs:
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    'sbg:x': 1048.015625
    'sbg:y': 0
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    'sbg:x': 1048.015625
    'sbg:y': 107
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    'sbg:x': 1048.015625
    'sbg:y': 214
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    'sbg:x': 1048.015625
    'sbg:y': 321
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    'sbg:x': 625.828125
    'sbg:y': 32.5
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    'sbg:x': 625.828125
    'sbg:y': 139.5
  - id: assembly_dir
    outputSource:
      - trinity_se/assembly_dir
    type: Directory
    label: Assembly directory containing assembly results
    description: ''
    'sbg:x': -101.71600341796875
    'sbg:y': -246
steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: trinity_se/assembled_contigs
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames
    'sbg:x': 187
    'sbg:y': 292
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: transcriptsFile
        source: trinity_se/assembled_contigs
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: >-
      TransDecoder.Predict: Perl script, which predicts the likely coding
      regions
    'sbg:x': 495
    'sbg:y': 291
  - id: cd_hit_est
    in:
      - id: input
        source: trinity_se/assembled_contigs
      - id: outName
        source: outName
    out:
      - id: outClstr
      - id: outSeq
    run: ../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 253
    'sbg:y': 80
  - id: trinity_se
    in:
      - id: single_reads
        source: single_reads
    out:
      - id: assembly_dir
      - id: assembled_contigs
    run: ../tools/trinity/trinity_se.cwl
    label: Trinity assembles transcript sequences from Illumina RNA-Seq data.
    'sbg:x': -319
    'sbg:y': -21
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
