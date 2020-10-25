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

  - id: left_reads
    type: File
    label: left read(s)

outputs:
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file

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

  - id: cd_hit_est
    in:
      - id: input
        source: trinity_pe/assembled_contigs
    out:
      - id: outClstr
      - id: outSeq
    run: ../../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est

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

requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
