cwlVersion: v1.0
class: CommandLineTool
label: "Homer (Hypergeometric Optimization of Motif EnRichment) is a suite of tools for Motif Discovery and ChIP-Seq analysis"
doc: >
    "Homer (Hypergeometric Optimization of Motif EnRichment) is a suite of tools for Motif Discovery and ChIP-Seq analysis. 
    It is a collection of command line programs for unix-style operating systems written in mostly perl and c++. 
    Homer was primarily written as a de novo motif discovery algorithm that is well suited for finding 8-12 bp 
    motifs in large scale genomics data."

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerImageId: homer_mouse:4.11

baseCommand: [ annotatePeaks.pl ]

inputs:
  tss_centric:
    label: "for TSS specific analysis"
    doc: "if tss is given as the first argument, above will occur.
          Tag counts and motifs will be found relative to the TSS"