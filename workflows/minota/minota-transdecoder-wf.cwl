class: Workflow
cwlVersion: v1.0
id: minota_transdecoder_trinity_pe
label: minota-transdecoder-trinity_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: geneToTranscriptMap
    type: File
    label: gene-to-transcript mapping
    'sbg:x': -124.51541900634766
    'sbg:y': -153.1806182861328
  - id: transcriptsFile
    type: File
    label: transcripts.fasta
    'sbg:x': -102.1894302368164
    'sbg:y': -285.7092590332031
outputs:
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    'sbg:x': 540.8766479492188
    'sbg:y': -419.3568420410156
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    'sbg:x': 548
    'sbg:y': -306.6343688964844
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    'sbg:x': 546.2334594726562
    'sbg:y': -180.0176239013672
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    'sbg:x': 531.9779663085938
    'sbg:y': -49.77532958984375
steps:
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: geneToTranscriptMap
        source: geneToTranscriptMap
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: workingDir
    run: ../../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames
    'sbg:x': 76.15419006347656
    'sbg:y': -115.50660705566406
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: retainBlastpHits
        default: true
      - id: retainPredictMode
        default: true
      - id: retainPfamHits
        default: true
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: >-
      TransDecoder.Predict: Perl script, which predicts the likely coding
      regions
    'sbg:x': 250.99998474121094
    'sbg:y': -256.51983642578125
requirements:
  - class: SubworkflowFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
