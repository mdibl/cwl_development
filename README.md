# cwl_development

A repository primarily for the development of CWL code. This is an evolution of the now somewhat-deprecated repository, biocore_analysis.
biocore_analysis will now be used strictly for experimental sample configuration files, while this repo will store CWL code and *only* test config files.

The general structure (subject to change) may be defined as the following:

* cwl_development (root)
  * code
    * tool-name (must mimic tool as called on the CLI)
      * version(?)
        * cwl code
        * yaml configuration file
  * workflow
    * workflow-type
      * workflow-sub-type
        * cwl code
        * yaml configuration file
