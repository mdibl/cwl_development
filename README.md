# cwl_development

A repository primarily for the development of CWL code. This is an evolution of the now somewhat-deprecated repository, biocore_analysis.
biocore_analysis should be used only for experimental sample configuration files, while this repo will store CWL code and template config files.

The general structure (subject to change) may be defined as the following:

* cwl_development (root)
  * code
    * tool-name (should mimic tool as called on the CLI)
      * version(?)
        * cwl code
        * configuration dir
          * yaml configuration file
  * workflow
    * workflow-type
      * workflow-sub-type
        * cwl code
        * configuration dir
          * yaml configuration file
