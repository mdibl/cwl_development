class: Workflow
cwlVersion: v1.0
id: minota_qc_se
label: minota-qc_se
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: File
    'sbg:x': -616.3636474609375
    'sbg:y': -105.39393615722656
outputs:
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': -232
    'sbg:y': 67
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -230
    'sbg:y': -80
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -136.21212768554688
    'sbg:y': -569.0216064453125
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -155.4545440673828
    'sbg:y': -439.9696960449219
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': -140.5454559326172
    'sbg:y': -338.5454406738281
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': 7.393942356109619
    'sbg:y': -280.8484802246094
  - id: fastq1_trimmed
    outputSource:
      - trim_galore/fastq1_trimmed
    type: File
    'sbg:x': -15
    'sbg:y': -147.15151977539062
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
    'sbg:x': -371.6363525390625
    'sbg:y': 10.303030014038086
  - id: trim_galore
    in:
      - id: fastq1
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
    'sbg:x': -373.7272644042969
    'sbg:y': -233.72727966308594
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
