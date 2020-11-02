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

    'sbg:x': -436.07415771484375
    'sbg:y': -126.92986297607422
  - id: left_reads
    type: File
    label: left read(s)

    'sbg:x': -417.048095703125
    'sbg:y': 101
outputs:
  - id: fastqc_result
    outputSource:
      - fastqc/fastqc_result
    type: 'File[]'

    'sbg:x': -104.9238510131836
    'sbg:y': -305.99798583984375
  - id: fastqc_result_1
    outputSource:
      - fastqc_1/fastqc_result
    type: 'File[]'

    'sbg:x': -112.94188690185547
    'sbg:y': 255
  - id: trans_map
    outputSource:
      - trinity_pe/trans_map
    type: File
    label: Gene-to-trans-map

    'sbg:x': -33.0861701965332
    'sbg:y': -152.03005981445312
  - id: timing_file
    outputSource:
      - trinity_pe/timing_file
    type: File
    label: trinity.timing file

    'sbg:x': -51.969940185546875
    'sbg:y': -27.054109573364258
  - id: assembled_contigs
    outputSource:
      - trinity_pe/assembled_contigs
    type: File
    label: Generated contigs

    'sbg:x': -47.909820556640625
    'sbg:y': 112.98397064208984
steps:
  - id: trinity_pe
    in:
      - id: left_reads
        source: left_reads
      - id: right_reads
        source: right_reads
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
        source:
          - right_reads
    out:
      - id: fastqc_result
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -292.69537353515625
    'sbg:y': -240.86973571777344
  - id: fastqc_1
    in:
      - id: seqfile
        source:
          - left_reads
    out:
      - id: fastqc_result
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -260.49700927734375
    'sbg:y': 205.2324676513672
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
