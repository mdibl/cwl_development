class: Workflow
cwlVersion: v1.0
id: stranded_pe
label: stranded_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: File
    description: ''
    'sbg:x': -1193
    'sbg:y': -89
  - id: seqfile_1
    type: File
    description: ''
    'sbg:x': -1191
    'sbg:y': -301
outputs:
  - id: zipped_results_1
    outputSource:
      - minota_qc_pe/zipped_results_1
    type: 'File[]'
    description: ''
    'sbg:x': -529
    'sbg:y': -720
  - id: zipped_results
    outputSource:
      - minota_qc_pe/zipped_results
    type: 'File[]'
    description: ''
    'sbg:x': -512
    'sbg:y': -591
  - id: trimmed_fastqc_zip
    outputSource:
      - minota_qc_pe/trimmed_fastqc_zip
    type: 'File[]'
    description: ''
    'sbg:x': -498
    'sbg:y': -486
  - id: trimmed_fastqc_html
    outputSource:
      - minota_qc_pe/trimmed_fastqc_html
    type: 'File[]'
    description: ''
    'sbg:x': -499
    'sbg:y': -377
  - id: trim_galore_log
    outputSource:
      - minota_qc_pe/trim_galore_log
    type: 'File[]'
    description: ''
    'sbg:x': -486
    'sbg:y': -291
  - id: html_report_1
    outputSource:
      - minota_qc_pe/html_report_1
    type: 'File[]'
    description: ''
    'sbg:x': -487
    'sbg:y': -214
  - id: html_report
    outputSource:
      - minota_qc_pe/html_report
    type: 'File[]'
    description: ''
    'sbg:x': -480
    'sbg:y': -101
  - id: fastq2_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq2_trimmed_unpaired
    type: File?
    description: ''
    'sbg:x': -491
    'sbg:y': 6
  - id: fastq2_trimmed
    outputSource:
      - minota_qc_pe/fastq2_trimmed
    type: File?
    description: ''
    'sbg:x': -500
    'sbg:y': 106
  - id: fastq1_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq1_trimmed_unpaired
    type: File?
    description: ''
    'sbg:x': -639
    'sbg:y': 137
  - id: fastq1_trimmed
    outputSource:
      - minota_qc_pe/fastq1_trimmed
    type: File
    description: ''
    'sbg:x': -701
    'sbg:y': 242
steps:
  - id: minota_qc_pe
    in:
      - id: seqfile
        source: seqfile
      - id: seqfile_1
        source: seqfile_1
    out:
      - id: trimmed_fastqc_zip
      - id: trimmed_fastqc_html
      - id: trim_galore_log
      - id: fastq2_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq1_trimmed
      - id: zipped_results
      - id: html_report
      - id: html_report_1
      - id: zipped_results_1
    run: ../../minota/minota-qc_pe.cwl
    label: minota-qc_pe
    'sbg:x': -978
    'sbg:y': -194
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
