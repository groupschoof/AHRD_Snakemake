import pandas as pd
from pathlib import Path

#configfile: "config.yaml"
species_table = pd.read_table("../resources/species.tsv").set_index("species")
SPECIES = species_table.index.tolist()

def get_species_fasta(wildcards):
    return species_table.loc[wildcards.species]["pep_fasta"]

def calc_mem_usage_in_mb(wildcards):
    fastaPath = species_table.loc[wildcards.species]["pep_fasta"]
    fastaSizeInByte = Path(fastaPath).stat().st_size
    fastaSizeInKB = fastaSizeInByte/1024
    fastaSizeInMB = fastaSizeInKB/1024
    projectedMemUsage = 11000+fastaSizeInMB*540
    return int(projectedMemUsage)

include: "rules/download.smk"
include: "rules/diamond.smk"
include: "rules/get_ahrd.smk"
include: "rules/create_ahrd_input.smk"
include: "rules/run_ahrd.smk"

rule all:
    input:
        expand("../results/{species}.ahrd_output.tsv", species=SPECIES)

