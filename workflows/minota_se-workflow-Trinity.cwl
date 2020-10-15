class: Workflow
cwlVersion: v1.0
id: minota_se_workflow
label: minota_se-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: transcriptsFile
    type: File
    'sbg:x': -85
    'sbg:y': -46
  - id: outName
    type: string
    'sbg:x': 0
    'sbg:y': 214
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
steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames
    'sbg:x': 160.265625
    'sbg:y': 214
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: >-
      TransDecoder.Predict: Perl script, which predicts the likely coding
      regions
    'sbg:x': 625.828125
    'sbg:y': 267.5
  - id: cd_hit_est
    in:
      - id: input
        source: transcriptsFile
      - id: outName
        source: outName
    out:
      - id: outClstr
      - id: outSeq
    run: ../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 160.265625
    'sbg:y': 100
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
