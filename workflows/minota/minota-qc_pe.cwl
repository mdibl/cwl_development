class: Workflow
cwlVersion: v1.0
id: minota_qc_pe
label: minota-qc_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: File
    'sbg:x': -420
    'sbg:y': -142
  - id: seqfile_1
    type: File
    'sbg:x': -440
    'sbg:y': 111.99964141845703
outputs:
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': 144
    'sbg:y': -258
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': 143
    'sbg:y': -137
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': 189
    'sbg:y': -54
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': 153
    'sbg:y': 37
  - id: fastq2_trimmed
    outputSource:
      - trim_galore/fastq2_trimmed
    type: File?
    'sbg:x': 144
    'sbg:y': 154
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': 157
    'sbg:y': 272
  - id: fastq1_trimmed
    outputSource:
      - trim_galore/fastq1_trimmed
    type: File
    'sbg:x': 54
    'sbg:y': 304
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -129
    'sbg:y': -315
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': -123
    'sbg:y': -185
  - id: html_report_1
    outputSource:
      - fastqc_1/html_report
    type: 'File[]'
    'sbg:x': -183
    'sbg:y': 312
  - id: zipped_results_1
    outputSource:
      - fastqc_1/zipped_results
    type: 'File[]'
    'sbg:x': -192
    'sbg:y': 140
steps:
  - id: fastqc
    in:
      - id: seqfile
        source: seqfile
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -286
    'sbg:y': -239
  - id: trim_galore
    in:
      - id: fastq1
        source: seqfile_1
      - id: fastq2
        source: seqfile
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ../../tools/trim_galore/trim_galore.cwl
    'sbg:x': -155
    'sbg:y': -4
  - id: fastqc_1
    in:
      - id: seqfile
        source: seqfile_1
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -322
    'sbg:y': 229
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
