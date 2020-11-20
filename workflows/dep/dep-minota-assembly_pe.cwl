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
    'sbg:x': -482.4364013671875
    'sbg:y': -305.5238037109375
  - id: left_reads
    type: File
    label: left read(s)
    'sbg:x': -496
    'sbg:y': 110.15209197998047
  - id: trinity_ss_lib_type
    type: string
    label: trinity read orientation
    'sbg:x': -332.5685729980469
    'sbg:y': -189.6908416748047
  - id: output_dir
    type: string
    label: name of output file for Trinity (must include Trinity in name)
    'sbg:x': -549.9900512695312
    'sbg:y': -112.24947357177734
outputs:
  - id: zipped_results
    outputSource:
      - fastqc/zipped_results
    type: 'File[]'
    'sbg:x': -61.162044525146484
    'sbg:y': -577.224609375
  - id: html_report
    outputSource:
      - fastqc/html_report
    type: 'File[]'
    'sbg:x': -52.828006744384766
    'sbg:y': -420.97015380859375
  - id: zipped_results_1
    outputSource:
      - fastqc_1/zipped_results
    type: 'File[]'
    'sbg:x': -36.70575714111328
    'sbg:y': 266.1272277832031
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
    'sbg:x': -14.588479995727539
    'sbg:y': 404.127197265625
  - id: outSeq
    outputSource:
      - cd_hit_est/outSeq
    type: File
    'sbg:x': 487.62994384765625
    'sbg:y': -229.74012756347656
  - id: outClstr
    outputSource:
      - cd_hit_est/outClstr
    type: File
    'sbg:x': 499.3849182128906
    'sbg:y': -97.21492767333984
  - id: peptide_sequences
    outputSource:
      - _trans_decoder__predict_v5/peptide_sequences
    type: File
    'sbg:x': 783.6323852539062
    'sbg:y': -172.1768035888672
  - id: gff3_output
    outputSource:
      - _trans_decoder__predict_v5/gff3_output
    type: File
    'sbg:x': 819.7786865234375
    'sbg:y': -29.25536346435547
  - id: coding_regions
    outputSource:
      - _trans_decoder__predict_v5/coding_regions
    type: File
    'sbg:x': 828.4737548828125
    'sbg:y': 117.59288787841797
  - id: bed_output
    outputSource:
      - _trans_decoder__predict_v5/bed_output
    type: File
    'sbg:x': 799.1021728515625
    'sbg:y': 265.3375244140625
  - id: transrate_output_dir
    outputSource:
      - _transrate__v1_0_3/transrate_output_dir
    type: Directory
    'sbg:x': 661.4065551757812
    'sbg:y': 596.8379516601562
  - id: quant_output
    outputSource:
      - kallisto_quant_pe/quant_output
    type: Directory
    'sbg:x': 1453.6884765625
    'sbg:y': 435.8846130371094
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
    'sbg:x': -260.7156982421875
    'sbg:y': -53.27434539794922
  - id: fastqc
    in:
      - id: seqfile
        source: right_reads
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -294.99005126953125
    'sbg:y': -467.3617858886719
  - id: fastqc_1
    in:
      - id: seqfile
        source: left_reads
    out:
      - id: html_report
      - id: zipped_results
    run: ../../tools/fastqc/fastqc.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -251.85287475585938
    'sbg:y': 275.8280029296875
  - id: cd_hit_est
    in:
      - id: input
        source: trinity_pe/assembled_contigs
    out:
      - id: outClstr
      - id: outSeq
    run: ../../tools/cd-hit-est/cd-hit-est.cwl
    label: CD-HIT-est
    'sbg:x': 304.9606628417969
    'sbg:y': -138.37159729003906
  - id: _trans_decoder__long_orfs_v5
    in:
      - id: geneToTranscriptMap
        source: trinity_pe/trans_map
      - id: transcriptsFile
        source: trinity_pe/assembled_contigs
    out:
      - id: workingDir
    run: ../../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: >-
      TransDecoder.LongOrfs: Perl script, which extracts the long open reading
      frames
    'sbg:x': 364.1227722167969
    'sbg:y': 130.11514282226562
  - id: _trans_decoder__predict_v5
    in:
      - id: longOpenReadingFrames
        source: _trans_decoder__long_orfs_v5/workingDir
      - id: transcriptsFile
        source: trinity_pe/assembled_contigs
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: >-
      TransDecoder.Predict: Perl script, which predicts the likely coding
      regions
    'sbg:x': 645.2709350585938
    'sbg:y': 83.57586669921875
  - id: _transrate__v1_0_3
    in:
      - id: in_fasta
        source: trinity_pe/assembled_contigs
      - id: left_fastq
        source: left_reads
      - id: right_fastq
        source: right_reads
    out:
      - id: transrate_output_dir
    run: ../../tools/transrate/Transrate-V1.0.3.cwl
    label: Transrate - A de-novo transcriptome assembly evaluation facility.
    'sbg:x': 336.4015808105469
    'sbg:y': 386.87774658203125
  - id: kallisto_index
    in:
      - id: fasta_files
        source:
          - trinity_pe/assembled_contigs
    out:
      - id: index_file
    run: ../../tools/kallisto/kallisto-index.cwl
    label: >-
      kallisto index: builds an index from a FASTA formatted file of target
      sequences
    'sbg:x': 749.3783569335938
    'sbg:y': 425.30584716796875
  - id: kallisto_quant_pe
    in:
      - id: fq1
        source: right_reads
      - id: fq2
        source: left_reads
      - id: index_file
        source: kallisto_index/index_file
    out:
      - id: quant_output
    run: ../../tools/kallisto/kallisto-quant_pe.cwl
    label: 'kallisto quant: runs the quantification algorithm'
    'sbg:x': 1160.6610107421875
    'sbg:y': 434.4715881347656
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
