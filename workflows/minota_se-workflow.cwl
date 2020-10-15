class: Workflow
cwlVersion: v1.0
id: minota_se_workflow
label: minota_se-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: transcriptsFile
    type: File
    label: FASTA formatted sequence file containing your transcripts.
    'sbg:x': -708
    'sbg:y': -176
outputs:
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    label: peptide sequences
    'sbg:x': 84
    'sbg:y': -514
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    label: gff3 output
    'sbg:x': 85
    'sbg:y': -379
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    label: coding regions
    'sbg:x': 86
    'sbg:y': -234
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    label: bed output
    'sbg:x': 80
    'sbg:y': -85
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    label: Output fasta format file
    'sbg:x': -281
    'sbg:y': -32
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    label: Output cluster mapping file
    'sbg:x': -280
    'sbg:y': 162
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
    'sbg:x': -462
    'sbg:y': -382
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
    'sbg:x': -201
    'sbg:y': -227
  - id: cd_hit_est
    in:
      - id: input
        source: transcriptsFile
    out:
      - id: outClstr
      - id: outSeq
    run: ../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': -486
    'sbg:y': 58
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
