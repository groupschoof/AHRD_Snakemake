def get_species_fasta(wildcards):
    return species_table.loc[wildcards.species]["pep_fasta"]
