'''
WORKFLOW FOR EPA PLACEMENTS COMPUTATION
This file describes the pipeline itself.
It calls many other SnakeFiles (*.smk) which are modules dedicated to the different operations.
@author Benjamin Linard
'''

#this config file is not set globally for all subworkflows
configfile: "config.yaml"

#prunings
include:
    "modules/op/operate_prunings.smk"
include:
    "modules/op/operate_optimisation.smk"
#rappas placements
include:
    "modules/op/operate_ar.smk"
include:
    "modules/placement/placement_rappas_dbondisk.smk"


rule all:
    input: expand(config["workdir"]+"/RAPPAS/{pruning}/k{k}_o{omega}_config/{pruning}_r{length}_k{k}_o{omega}_rappas.jplace", pruning=1, k=[6,7],omega=1.00,length=config["read_length"])