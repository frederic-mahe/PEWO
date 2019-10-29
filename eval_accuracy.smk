'''
WORKFLOW TO EVALUATE PLACEMENT ACCURACY, GIVEN PARAMETERS SET IN "config.yaml"
This snakefile loads all necessary modules and builds the evaluation workflow itself
based on the setup defined in the config file.
@author Benjamin Linard
'''

configfile: "config.yaml"

'''
explicitly set config to not repeat launches,
which is an option that should be considered only in 'resource' evaluation mode.
this allow to use the same config file for both 'accuracy' and 'resources' modes
NOTE: this statement MUST be set BEFORE the "includes"
'''
config["repeats"]=1

#utils
include:
    "modules/utils/wk.smk"
include:
    "modules/utils/etc.smk"
#prunings
include:
    "modules/op/operate_prunings.smk"
#tree optimisation
include:
    "modules/op/operate_optimisation.smk"
#phylo-kmer placement, e.g.: rappas
include:
    "modules/op/operate_ar.smk"
include:
    "modules/placement/placement_rappas_dbinram.smk"
#alignment (for distance-based and ML approaches)
include:
    "modules/alignment/alignment_hmm.smk"
#ML-based placements, e.g.: epa, epang, pplacer
include:
    "modules/placement/placement_epa.smk"
include:
    "modules/placement/placement_pplacer.smk"
include:
    "modules/placement/placement_epang_h1.smk"
include:
    "modules/placement/placement_epang_h2.smk"
include:
    "modules/placement/placement_epang_h3.smk"
include:
    "modules/placement/placement_epang_h4.smk"
#distance-based placements, e.g.: apples
include:
    "modules/placement/placement_apples.smk"
#results evaluation and plots
include:
    "modules/op/operate_nodedistance.smk"
include:
    "modules/op/operate_plots.smk"

'''
top snakemake rule, necessary to launch the workflow
'''
rule all:
     input:
         build_accuracy_workflow()