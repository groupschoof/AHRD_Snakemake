rule make_blast_db_swissprot:
    input: rules.download_swissprot.output
    output: "resources/uniprot_sprot.fasta.pin"
    log: "logs/make_blast_db_swissprot.log"
    benchmark: "benchmark/make_blast_db_swissprot.txt"
    conda: "../envs/blast.yaml"
    shell: "makeblastdb -in {input} -dbtype prot &> {log}"

rule make_blast_db_uniref50:
    input: rules.download_uniref50.output
    output: "resources/uniref50.fasta.14.pin"
    log: "logs/make_blast_db_uniref50.log"
    benchmark: "benchmark/make_blast_db_uniref50.txt"
    conda: "../envs/blast.yaml"
    shell:  "makeblastdb -in {input} -dbtype prot &> {log}"

rule blast_swissprot:
    input: rules.make_blast_db_swissprot.output
    params:
        fa = get_species_fasta,
        db = rules.download_swissprot.output
    output: "results/{species}_IN_swissprot.tsv"
    log: "logs/{species}_IN_swissprot.log"
    benchmark: "benchmark/{species}_IN_swissprot.txt"
    conda: "../envs/blast.yaml"	
    threads: workflow.cores * config["cpu_usage"]["small_jobs"]
    shell: "blastp -query {params.fa} -db {params.db} -out {output} -outfmt 6 -num_alignments 300 -evalue 1 -num_threads {threads} &> {log}"

rule blast_uniref50:
    input: rules.make_blast_db_uniref50.output
    params:
        fa = get_species_fasta,
        db = rules.download_uniref50.output
    output: "results/{species}_IN_uniref50.tsv"
    log: "logs/{species}_IN_uniref50.log"
    benchmark: "benchmark/{species}_IN_uniref50.txt"
    conda: "../envs/blast.yaml"
    threads: workflow.cores * config["cpu_usage"]["large_jobs"]
    shell: "blastp -query {params.fa} -db {params.db} -out {output} -outfmt 6 -num_alignments 300 -evalue 1 -num_threads {threads} &> {log}"
