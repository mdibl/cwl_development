class: Workflow
cwlVersion: v1.0
id: core_star_rna_seq_pe
label: core-STAR-rna-seq_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile_1
    type: File
    'sbg:x': -795
    'sbg:y': -270
  - id: seqfile
    type: File
    'sbg:x': -783
    'sbg:y': -59
  - id: genomeDir
    type: Directory
    'sbg:x': 125.39891052246094
    'sbg:y': -158.5413360595703
  - id: nthreads
    type: int
outputs:
  - id: zipped_results_1
    outputSource:
      - minota_qc_pe/zipped_results_1
    type: 'File[]'
    'sbg:x': -202.18739318847656
    'sbg:y': -825.3216552734375
  - id: zipped_results
    outputSource:
      - minota_qc_pe/zipped_results
    type: 'File[]'
    'sbg:x': -204.03561401367188
    'sbg:y': -728.3216552734375
  - id: trimmed_fastqc_zip
    outputSource:
      - minota_qc_pe/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': -194.33917236328125
    'sbg:y': -618.9287719726562
  - id: trimmed_fastqc_html
    outputSource:
      - minota_qc_pe/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': -188.49095153808594
    'sbg:y': -510.9704284667969
  - id: trim_galore_log
    outputSource:
      - minota_qc_pe/trim_galore_log
    type: 'File[]'
    'sbg:x': -191.47012329101562
    'sbg:y': -405.7293395996094
  - id: html_report_1
    outputSource:
      - minota_qc_pe/html_report_1
    type: 'File[]'
    'sbg:x': -194.9939727783203
    'sbg:y': -304.4674072265625
  - id: html_report
    outputSource:
      - minota_qc_pe/html_report
    type: 'File[]'
    'sbg:x': -193.06246948242188
    'sbg:y': -194.83343505859375
  - id: fastq2_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': -190.8213653564453
    'sbg:y': -93.39619445800781
  - id: fastq1_trimmed_unpaired
    outputSource:
      - minota_qc_pe/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': -194.08599853515625
    'sbg:y': -11.529871940612793
  - id: toTranscriptome_bam
    outputSource:
      - _s_t_a_r_mapping_pe/toTranscriptome_bam
    type: File
    'sbg:x': 583.7703857421875
    'sbg:y': -283.8711853027344
  - id: spliceJunctions
    outputSource:
      - _s_t_a_r_mapping_pe/spliceJunctions
    type: File
    'sbg:x': 583.0355834960938
    'sbg:y': -161.44659423828125
  - id: readsPerGene
    outputSource:
      - _s_t_a_r_mapping_pe/readsPerGene
    type: File
    'sbg:x': 592.1128540039062
    'sbg:y': -51.363304138183594
  - id: output_bam
    outputSource:
      - _s_t_a_r_mapping_pe/output_bam
    type: File
    'sbg:x': 592.0296020507812
    'sbg:y': 59.7468376159668
  - id: logfiles
    outputSource:
      - _s_t_a_r_mapping_pe/logfiles
    type: 'File[]'
    'sbg:x': 579.71728515625
    'sbg:y': 192.78848266601562
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
    'sbg:x': -575.804443359375
    'sbg:y': -179.27096557617188
  - id: _s_t_a_r_mapping_pe
    in:
      - id: fq1
        source: minota_qc_pe/fastq1_trimmed
      - id: fq2
        source: minota_qc_pe/fastq2_trimmed
      - id: genomeDir
        source: genomeDir
      - id: nthreads
        source: nthreads
    out:
      - id: logfiles
      - id: output_bam
      - id: readsPerGene
      - id: spliceJunctions
      - id: toTranscriptome_bam
    run: ../../../tools/STAR/STAR-mapping_pe.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': 353.934814453125
    'sbg:y': 57.54796600341797
requirements:
  - class: SubworkflowFeatureRequirement
