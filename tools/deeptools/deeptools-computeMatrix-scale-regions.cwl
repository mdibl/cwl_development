#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement

doc: |
  In the scale-regions mode, all regions 
  in the BED file are stretched or shrunken to 
  the length (in bases) indicated by the user.

hints:
  ResourceRequirement:
    coresMin: 1
    ramMin: 20000
  DockerRequirement:
    dockerPull: kerstenbreuer/deeptools:3.1.1
  SoftwareRequirement:
    packages:
      deeptools:
        specs: [ "http://identifiers.org/biotools/deeptools" ]
        version: [ "3.1.1" ]

baseCommand: ["computeMatrix", "scale-regions"]
arguments:  
  - valueFrom: $(inputs.bam.nameroot).bigwig
    prefix: --outFileName
    position: 10

inputs:
  regionsFileName:
    doc: file, in BED or GTF format, containing the regions to plot
    type: File
    inputBinding:
      prefix: --regionsFileName
      position: 10
  scoreFileName:
    doc: |
      bigwig file(s) containing scores to be plotted, multiple files should
      seperated by spaces
    type: File[]
    inputBinding:
      prefix: --scoreFileName
      position: 10
  beforeRegionStartLength:
    doc: |
      distance upstream of the start stie of the regions defined
      in region file. If regions are genes, would be distance upstream
      of TSS (Default: 0)
    type: int?
    inputBinding:
      prefix: --upstream
      position: 10
  afterRegionStartLength:
    doc: |
      distance downstream of the end site of the given regions,
      if regions are genes, would be distance downstream of TES
      (Default: 0)
    type: int?
    inputBinding:
      prefix: --downstream
      position: 10
  

