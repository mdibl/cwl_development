cwlVersion: v1.0
class: CommandLineTool
label: "ABySS is a de novo sequence assembler intended for short paired-end reads and large genomes."

hints:
  DockerRequirement:
    dockerPull: biocontainers/abyss:2.2.4--ha4ec83a_0

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ ABYSS ]
