class: Workflow
cwlVersion: v1.0
id: fastqc_trim_galore_workflow
label: fastqc-trim_galore-workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: 'File[]'
    'sbg:x': -331
    'sbg:y': 0
  - id: fastq1
    type: File
    'sbg:x': -318
    'sbg:y': 160
  - id: index_file
    type: File
    'sbg:x': 131
    'sbg:y': 489
outputs:
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': 51.53125
    'sbg:y': -204
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': 256
    'sbg:y': -180
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': 253
    'sbg:y': -60
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': 260
    'sbg:y': 68
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': 150
    'sbg:y': 350
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': 265
    'sbg:y': 173
  - id: fastq2_trimmed
    outputSource:
      - trim_galore/fastq2_trimmed
    type: File?
    'sbg:x': 241
    'sbg:y': 289
  - id: quant_output
    outputSource:
      - kallisto_quant_se/quant_output
    type: Directory
    'sbg:x': 447
    'sbg:y': 424
steps:
  - id: _fast_q_c
    in:
      - id: seqfile
        source:
          - seqfile
    out:
      - id: fastqc_result
    run: ./FastQC.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -119.1875
    'sbg:y': -104
  - id: trim_galore
    in:
      - id: fastq1
        source: fastq1
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -108
    'sbg:y': 105.5
  - id: kallisto_quant_se
    in:
      - id: fq
        source: trim_galore/fastq1_trimmed
      - id: index_file
        source: index_file
    out:
      - id: quant_output
    run: ./kallisto-quant_se.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': 209
    'sbg:y': 643.9920654296875
requirements: []
