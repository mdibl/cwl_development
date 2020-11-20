class: Workflow
cwlVersion: v1.0
id: minota_se_workflow
label: minota_se-workflow

inputs:
  - id: transcriptsFile
    type: File
  - id: outName
    type: string

outputs:
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File

  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File

  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File

  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File

  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File

  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File

steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl

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

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
