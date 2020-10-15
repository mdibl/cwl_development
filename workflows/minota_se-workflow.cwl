class: Workflow
cwlVersion: v1.0
id: minota_se_workflow
label: minota_se-workflow

inputs:
  - id: transcriptsFile
    type: File
    label: FASTA formatted sequence file containing your transcripts.

outputs:
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    label: peptide sequences

  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    label: gff3 output

  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    label: coding regions

  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    label: bed output

  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    label: Output fasta format file

  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    label: Output cluster mapping file

steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      'TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames'

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
      'TransDecoder.Predict: Perl script, which predicts the likely coding
      regions'

  - id: cd_hit_est
    in:
      - id: input
        source: transcriptsFile
    out:
      - id: outClstr
      - id: outSeq
      - id: outName
    run: ../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
