class: Workflow
cwlVersion: v1.0
id: minota_se_rnaspades
label: minota_se-rnaspades
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: single_reads
    type: File
  - id: outName
    type: string
  - id: threads
    type: int
  - id: memory
    type: int
  - id: rna_mode
    type: boolean

outputs:
  - id: transcript_file
    outputSource:
      - rnaspades/transcript_file
    type: File

  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File

  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File

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

steps:
  - id: rnaspades
    in:
      - id: single_reads
        source: single_reads
      - id: memory
        source: memory
      - id: threads
        source: threads
      - id: rna_mode
        source: rna_mode
    out:
      - id: transcript_file
    run: ../tools/spades/rnaspades.cwl

  - id: cd_hit_est
    in:
      - id: input
        source: rnaspades/transcript_file
      - id: outName
        source: outName
    out:
      - id: outClstr
      - id: outSeq
    run: ../tools/cd-hit-est/cd-hit-est.cwl

  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: rnaspades/transcript_file
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl

  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: transcriptsFile
        source: rnaspades/transcript_file
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../tools/TransDecoder/TransDecoder.Predict-v5.cwl

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
