class: Workflow
cwlVersion: v1.0
id: minota_assembly_rnaspades_pe
label: minota-assembly-rnaspades_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: seqfile
    type: File
    'sbg:x': -530.1578979492188
    'sbg:y': -247.15789794921875
  - id: seqfile_1
    type: File
    'sbg:x': -508.3008117675781
    'sbg:y': 76.37398529052734
  - id: output_prefix
    type: string
    label: prefix for cd-hit-est output files
  - id: memory
    type: int
    label: RAM
  - id: rna_mode
    type: boolean
    label: enable rna mode
  - id: threads
    type: int
    label: number of threads to use
outputs:
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -194
    'sbg:y': -456
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': -198
    'sbg:y': -337
  - id: zipped_results_1
    outputSource:
      - fastqc_1/zipped_results
    type: 'File[]'
    'sbg:x': -175.82113647460938
    'sbg:y': 60.544715881347656
  - id: html_report_1
    outputSource:
      - fastqc_1/html_report
    type: 'File[]'
    'sbg:x': -168.3739776611328
    'sbg:y': 185.8292694091797
  - id: trimmed_fastqc_zip
    outputSource:
      - trim_galore/trimmed_fastqc_zip
    type: 'File[]'
    'sbg:x': 88.99188995361328
    'sbg:y': -329.1788330078125
  - id: trimmed_fastqc_html
    outputSource:
      - trim_galore/trimmed_fastqc_html
    type: 'File[]'
    'sbg:x': 96.79071807861328
    'sbg:y': -219.7528839111328
  - id: trim_galore_log
    outputSource:
      - trim_galore/trim_galore_log
    type: 'File[]'
    'sbg:x': 103.55123901367188
    'sbg:y': -121.32898712158203
  - id: fastq2_trimmed_unpaired
    outputSource:
      - trim_galore/fastq2_trimmed_unpaired
    type: File?
    'sbg:x': 206.3280792236328
    'sbg:y': -27.461381912231445
  - id: fastq1_trimmed_unpaired
    outputSource:
      - trim_galore/fastq1_trimmed_unpaired
    type: File?
    'sbg:x': 159.8455352783203
    'sbg:y': 95.43902587890625
  - id: transrate_output_dir
    outputSource:
      - transrate/transrate_output_dir
    type: Directory
    'sbg:x': 691.6091918945312
    'sbg:y': -289.11053466796875
  - id: transcript_file
    outputSource:
      - rnaspades_pe/transcript_file
    type: File
    'sbg:x': 485.84210205078125
    'sbg:y': -41.73684310913086
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    'sbg:x': 594.2105102539062
    'sbg:y': -544.2105102539062
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    'sbg:x': 577.8421020507812
    'sbg:y': -398.2631530761719
steps:
  - id: rnaspades_pe
    in:
      - id: forward_reads
        source: trim_galore/fastq1_trimmed
      - id: reverse_reads
        source: trim_galore/fastq2_trimmed
      - id: memory
        source: memory
      - id: rna_mode
        source: rna_mode
      - id: threads
        source: threads
    out:
      - id: transcript_file
    run: ../../tools/spades/rnaspades_pe.cwl
    'sbg:x': 297.5330505371094
    'sbg:y': -136.4423370361328
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
    'sbg:x': -193.84210205078125
    'sbg:y': -125.0526351928711
  - id: fastqc
    in:
      - id: seqfile
        source: seqfile
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -365
    'sbg:y': -330
  - id: fastqc_1
    in:
      - id: seqfile
        source: seqfile_1
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -356.8699035644531
    'sbg:y': 125.1382064819336
  - id: transrate
    in:
      - id: in_fasta
        source: rnaspades_pe/transcript_file
      - id: left_fastq
        source: trim_galore/fastq1_trimmed
      - id: right_fastq
        source: trim_galore/fastq2_trimmed
    out:
      - id: transrate_output_dir
    run: ../../tools/transrate/transrate.cwl
    label: Transrate - A de-novo transcriptome assembly evaluation facility.
    'sbg:x': 471.1578674316406
    'sbg:y': -301.89471435546875
  - id: cd_hit_est
    in:
      - id: input
        source: rnaspades_pe/transcript_file
      - id: output_prefix
        source: output_prefix
    out:
      - id: outClstr
      - id: outSeq
    run: ../../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 450.7368469238281
    'sbg:y': -446.3684387207031
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
