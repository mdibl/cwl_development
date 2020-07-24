class: Workflow
cwlVersion: v1.0
id: workflow_pe
label: workflow_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq1
    type: File
    'sbg:x': -904.1851806640625
    'sbg:y': 106.36761474609375
  - id: index_file
    type: File
    'sbg:x': -223.92166137695312
    'sbg:y': 103.53487396240234
  - id: fastq2
    type: File?
    'sbg:x': -906
    'sbg:y': -47
  - id: seqfile
    type: 'File[]'
    'sbg:x': -900
    'sbg:y': 248
  - id: seqfile2
    type: 'File[]'
    'sbg:x': -909
    'sbg:y': -230
outputs:
  - id: fastqc_result
    outputSource:
      - _fast_q_c/fastqc_result
    type: 'File[]'
    'sbg:x': -408
    'sbg:y': 427
  - id: fastqc_result2
    outputSource:
      - _fast_q_c_1/fastqc_result
    type: 'File[]'
    'sbg:x': -442
    'sbg:y': -394
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -486
    'sbg:y': -273
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -414
    'sbg:y': -172
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': -381
    'sbg:y': -72
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': -381
    'sbg:y': 50
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -429
    'sbg:y': 299
  - id: quant_output
    outputSource:
      - kallisto_quant_pe/quant_output
    type: Directory
    'sbg:x': 268.8818359375
    'sbg:y': 295.33282470703125
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
    'sbg:x': -753.1651611328125
    'sbg:y': 215.6083221435547
  - id: _fast_q_c_1
    in:
      - id: seqfile
        source:
          - seqfile2
    out:
      - id: fastqc_result
    run: ./FastQC.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -748.2660522460938
    'sbg:y': -198.79959106445312
  - id: trim_galore
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
    out:
      - id: fastq1_trimmed
      - id: fastq1_trimmed_unpaired
      - id: fastq2_trimmed
      - id: fastq2_trimmed_unpaired
      - id: trim_galore_log
      - id: trimmed_fastqc_html
      - id: trimmed_fastqc_zip
    run: ./trim-galore.cwl
    'sbg:x': -707.185791015625
    'sbg:y': 20
  - id: kallisto_quant_pe
    in:
      - id: fq1
        source: trim_galore/fastq2_trimmed
      - id: fq2
        source: trim_galore/fastq1_trimmed
      - id: index_file
        source: index_file
    out:
      - id: quant_output
    run: ./kallisto-quant_pe.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': -42.26038360595703
    'sbg:y': 292.6689453125
requirements: []
