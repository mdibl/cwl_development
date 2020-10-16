class: Workflow
cwlVersion: v1.0
id: minota_se_trinity
label: minota_se-Trinity
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: single_reads
    type: File
  - id: outName
    type: string

outputs:
  - id: assembly_dir
    outputSource:
      - trinity_se/assembly_dir
    type: Directory

  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File

  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
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
  - id: trinity_se
    in:
      - id: single_reads
        source: single_reads
    out:
      - id: assembly_dir
      - id: assembled_contigs
    run: ../tools/trinity/trinity_se.cwl

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

  - id: _trans_decoder__long_orfs_v5
    in:
      - id: transcriptsFile
        source: trinity_se/assembled_contigs
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl

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

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
