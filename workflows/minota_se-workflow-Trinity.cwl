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
  - id: fq
    type: File
    description: ''
    'sbg:x': -573.7160034179688
    'sbg:y': -9
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
  - id: trinity_results
    outputSource:
      - exp_trinity_se/trinity_results
    type: Directory
    description: ''
    'sbg:x': -167.71600341796875
    'sbg:y': -201
steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: exp_trinity_se/trinity_fasta
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
        source: exp_trinity_se/trinity_fasta
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
        source: exp_trinity_se/trinity_fasta
      - id: outName
        source: outName
    out:
      - id: outClstr
      - id: outSeq
    run: ../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 253
    'sbg:y': 80
  - id: exp_trinity_se
    in:
      - id: fq
        source: fq
    out:
      - id: trinity_fasta
      - id: trinity_results
    run: ../tools/trinity/exp_trinity_se.cwl
    'sbg:x': -442
    'sbg:y': -9
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
