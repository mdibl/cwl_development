class: Workflow
cwlVersion: v1.0
id: minota_assembly_pe
label: minota-assembly_pe
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: right_reads
    type: File
    label: right read(s)
    'sbg:x': -506.4261474609375
    'sbg:y': -162.15011596679688
  - id: left_reads
    type: File
    label: left read(s)
    'sbg:x': -496.94915771484375
    'sbg:y': 138.4213104248047
  - id: trinity_ss_lib_type
    type: string
    label: trinity read orientation
    'sbg:x': -324.2978210449219
    'sbg:y': -119.7385025024414
  - id: output_dir
    type: string
    label: name of output file for Trinity (must include Trinity in name)
    'sbg:x': -520.738525390625
    'sbg:y': -3.581113815307617
outputs:
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -119
    'sbg:y': -393
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': 35
    'sbg:y': -331
  - id: zipped_results_1
    outputSource:
      - fastqc_1/zipped_results
    type: 'File[]'
    'sbg:x': -11.946731567382812
    'sbg:y': 219.57627868652344
  - id: trans_map
    outputSource:
      - trinity_pe/trans_map
    type: File
    label: Gene-to-trans-map
    'sbg:x': 32.42130661010742
    'sbg:y': -124.6295394897461
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file
    'sbg:x': 96.21307373046875
    'sbg:y': -19.314769744873047
  - id: assembled_contigs
    outputSource:
      - trinity_pe/assembled_contigs
    type: File
    label: Generated contigs
    'sbg:x': 27.685230255126953
    'sbg:y': 87.63438415527344
  - id: html_report_1
    outputSource:
      - fastqc_1/html_report
    type: 'File[]'
    'sbg:x': -66.10411834716797
    'sbg:y': 357
steps:
  - id: trinity_pe
    in:
      - id: left_reads
        source: left_reads
      - id: right_reads
        source: right_reads
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
    'sbg:x': -265.0461120605469
    'sbg:y': -19.977956771850586
  - id: fastqc
    in:
      - id: seqfile
        source: right_reads
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -265.4745788574219
    'sbg:y': -266.3196105957031
  - id: fastqc_1
    in:
      - id: seqfile
        source: left_reads
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -239
    'sbg:y': 188
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
