rule make_diamond_db_swissprot:
    input: rules.download_swissprot.output
    output: "results/uniprot_sprot.dmnd"
    log: "logs/make_diamond_db_swissprot.log"
    benchmark: "benchmark/make_diamond_db_swissprot.txt"
    conda: "../envs/diamond.yaml"
    threads: workflow.cores * config["cpu_usage"]["small_jobs"]
    shell: "diamond makedb --in {input} --threads {threads} -d results/uniprot_sprot &> {log}"

rule make_diamond_db_uniref50:
    input: rules.download_uniref50.output
    output: "results/uniref50.dmnd"
    log: "logs/make_diamond_db_uniref50.log"
    benchmark: "benchmark/make_diamond_db_uniref50.txt"
    conda: "../envs/diamond.yaml"
    threads: workflow.cores * config["cpu_usage"]["large_jobs"]
    shell:  "diamond makedb --in {input} --threads {threads} -d results/uniref50 &> {log}"

rule diamond_swissprot:
    input: rules.make_diamond_db_swissprot.output
    params: fa = get_species_fasta
    output: "results/{species}_IN_swissprot.tsv"
    log: "logs/{species}_IN_swissprot.log"
    benchmark: "benchmark/{species}_IN_swissprot.txt"
    conda: "../envs/diamond.yaml"	
    threads: workflow.cores * config["cpu_usage"]["small_jobs"]
    shell: "diamond blastp --query {params.fa} --db {input} --out {output} --sensitive --max-target-seqs 300 --evalue 1 --threads {threads} --tmpdir /dev/shm &> {log}"

rule diamond_uniref50:
    input: rules.make_diamond_db_uniref50.output
    params: fa = get_species_fasta
    output: "results/{species}_IN_uniref50.tsv"
    log: "logs/{species}_IN_uniref50.log"
    benchmark: "benchmark/{species}_IN_uniref50.txt"
    conda: "../envs/diamond.yaml"
    threads: workflow.cores * config["cpu_usage"]["large_jobs"]
    shell: "diamond blastp --query {params.fa} --db {input} --out {output} --mid-sensitive --max-target-seqs 300 --evalue 1 --threads {threads} --tmpdir /dev/shm &> {log}"
