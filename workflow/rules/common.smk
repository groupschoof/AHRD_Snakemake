def get_species_fasta(wildcards):
    return species_table.loc[wildcards.species]["pep_fasta"]

def calc_mem_usage_in_mb(wildcards):
    fastaPath = species_table.loc[wildcards.species]["pep_fasta"]
    fastaSizeInByte = Path(fastaPath).stat().st_size
    fastaSizeInKB = fastaSizeInByte/1024
    fastaSizeInMB = fastaSizeInKB/1024
    projectedMemUsage = 11000+fastaSizeInMB*540
    return int(projectedMemUsage)
