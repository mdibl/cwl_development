class: Workflow
cwlVersion: v1.0
id: core_kallisto_rna_seq_pe
label: core-kallisto-RNA-seq_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile_1
    type: File
    'sbg:x': -525.92236328125
    'sbg:y': -270.5039367675781
  - id: seqfile
    type: File
    'sbg:x': -531.992919921875
    'sbg:y': -6.411764621734619
  - id: index_file
    type: File
    'sbg:x': 432.263916015625
    'sbg:y': -228.0435791015625
outputs:
  - id: zipped_results_1
    outputSource:
      - minota_qc_pe/zipped_results_1
    type: 'File[]'
    'sbg:x': 174.0726318359375
    'sbg:y': -715.1973266601562
  - id: zipped_results
    outputSource:
      - minota_qc_pe/zipped_results
    type: 'File[]'
    'sbg:x': 182.73365783691406
    'sbg:y': -597.2178955078125
  - id: trimmed_fastqc_zip
    outputSource:
      - minota_qc_pe/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': 190.82809448242188
    'sbg:y': -475.33172607421875
  - id: trimmed_fastqc_html
    outputSource:
      - minota_qc_pe/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': 193.5496368408203
    'sbg:y': -365.7675476074219
  - id: fastq1_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': 194.70701599121094
    'sbg:y': 329.1010437011719
  - id: fastq2_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': 196.5786895751953
    'sbg:y': 85.97821044921875
  - id: html_report
    outputSource:
      - minota_qc_pe/html_report
    type: 'File[]'
    'sbg:x': 199.4866943359375
    'sbg:y': -27.283294677734375
  - id: html_report_1
    outputSource:
      - minota_qc_pe/html_report_1
    type: 'File[]'
    'sbg:x': 196.4673309326172
    'sbg:y': -138.96124267578125
  - id: trim_galore_log
    outputSource:
      - minota_qc_pe/trim_galore_log
    type: 'File[]'
    'sbg:x': 186.47698974609375
    'sbg:y': -246.5980682373047
  - id: quant_output
    outputSource:
      - kallisto_quant_pe/quant_output
    type: Directory
    'sbg:x': 1000.896728515625
    'sbg:y': -88.75545501708984
  - id: fastq2_trimmed
    outputSource:
      - minota_qc_pe/fastq2_trimmed
    type: File?
    'sbg:x': 196.27603149414062
    'sbg:y': 212.76754760742188
  - id: fastq1_trimmed
    outputSource:
      - minota_qc_pe/fastq1_trimmed
    type: File
    'sbg:x': 199.2711944580078
    'sbg:y': 454.40435791015625
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
    'sbg:x': -264.1591796875
    'sbg:y': -128.73492431640625
  - id: kallisto_quant_pe
    in:
      - id: fq1
        source: minota_qc_pe/fastq1_trimmed
      - id: fq2
        source: minota_qc_pe/fastq2_trimmed
      - id: index_file
        source: index_file
    out:
      - id: quant_output
    run: ../../../tools/kallisto/kallisto-quant_pe.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': 663.3438110351562
    'sbg:y': 34.93947219848633
requirements:
  - class: SubworkflowFeatureRequirement
