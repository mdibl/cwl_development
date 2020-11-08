class: Workflow
cwlVersion: v1.0
id: minota_assembly_pe
label: minota-assembly_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: File
    'sbg:x': -433
    'sbg:y': -61
  - id: seqfile_1
    type: File
    'sbg:x': -425.7811279296875
    'sbg:y': 140.92703247070312
  - id: trinity_ss_lib_type
    type: string
    label: trinity read orientation
    'sbg:x': -332.5685729980469
    'sbg:y': -189.6908416748047
  - id: output_dir
    type: string
    label: name of output file for Trinity (must include Trinity in name)
    'sbg:x': -549.9900512695312
    'sbg:y': -112.24947357177734
  - id: output_prefix
    type: string
    label: prefix for cd-hit-est output files
outputs:
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    'sbg:x': 259.31329345703125
    'sbg:y': 16.021459579467773
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    'sbg:x': 262
    'sbg:y': 200.8540802001953
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file
    'sbg:x': 37.613731384277344
    'sbg:y': 3.583690881729126
  - id: transrate_output_dir
    outputSource:
      - transrate/transrate_output_dir
    type: Directory
    'sbg:x': 235.3347625732422
    'sbg:y': -205.67811584472656
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -138
    'sbg:y': -363.99957275390625
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': -144
    'sbg:y': -251
  - id: zipped_results_1
    outputSource:
      - fastqc_1/zipped_results
    type: 'File[]'
    'sbg:x': -93
    'sbg:y': 198.94850158691406
  - id: html_report_1
    outputSource:
      - fastqc_1/html_report
    type: 'File[]'
    'sbg:x': -76
    'sbg:y': 406
  - id: assembled_contigs
    outputSource:
      - trinity_pe/assembled_contigs
    type: File
    label: Generated contigs
    'sbg:x': 152.28326416015625
    'sbg:y': 372.7081604003906
  - id: trans_map
    outputSource:
      - trinity_pe/trans_map
    type: File
    label: Gene-to-trans-map
    'sbg:x': 303.66522216796875
    'sbg:y': 352.17596435546875
steps:
  - id: trinity_pe
    in:
      - id: left_reads
        source: seqfile_1
      - id: right_reads
        source: seqfile
      - id: trinity_ss_lib_type
        source: trinity_ss_lib_type
      - id: output_dir
        source: output_dir
    out:
      - id: assembled_contigs
      - id: trans_map
      - id: timing_file
    run: ../../tools/trinity/trinity_pe.cwl
    label: Trinity assembles transcript sequences from Illumina RNA-Seq data.
    'sbg:x': -208.07296752929688
    'sbg:y': 17.824033737182617
  - id: cd_hit_est
    in:
      - id: input
        source: trinity_pe/assembled_contigs
      - id: output_prefix
        source: output_prefix
    out:
      - id: outClstr
      - id: outSeq
    run: ../../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 79
    'sbg:y': 137
  - id: transrate
    in:
      - id: in_fasta
        source: trinity_pe/assembled_contigs
      - id: left_fastq
        source: seqfile_1
      - id: right_fastq
        source: seqfile
    out:
      - id: transrate_output_dir
    run: ../../tools/transrate/transrate.cwl
    label: Transrate - A de-novo transcriptome assembly evaluation facility.
    'sbg:x': 7
    'sbg:y': -146
  - id: fastqc
    in:
      - id: seqfile
        source: seqfile
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -312
    'sbg:y': -296
  - id: fastqc_1
    in:
      - id: seqfile
        source: seqfile_1
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -251
    'sbg:y': 304
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
