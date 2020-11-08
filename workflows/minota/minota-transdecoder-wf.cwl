class: Workflow
cwlVersion: v1.0
id: minota_transdecoder_wf
label: minota-transdecoder-wf
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: transcriptsFile
    type: File
    label: transcripts.fasta
    'sbg:x': -88
    'sbg:y': -238
  - id: geneToTranscriptMap
    type: File
    label: gene-to-transcript mapping
    'sbg:x': -189
    'sbg:y': -119
  - id: retainBlastpHits
    type: boolean
  - id: retainPfamHits
    type: boolean
  - id: retainPredictMode
    type: boolean
outputs:
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
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    'sbg:x': 504
    'sbg:y': -471
steps:
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: retainBlastpHits
        default: false
      - id: retainPredictMode
        default: false
      - id: retainPfamHits
        default: false
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
    'sbg:x': 20
    'sbg:y': -106
requirements:
  - class: SubworkflowFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
