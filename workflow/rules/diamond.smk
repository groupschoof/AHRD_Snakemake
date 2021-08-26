rule make_diamond_db_swissprot:
    input: rules.download_swissprot.output
    output: "../results/uniprot_sprot.dmnd"
    log: "logs/make_diamond_db_swissprot.log"
    benchmark: "benchmark/make_diamond_db_swissprot.txt"
    conda: "../envs/diamond.yaml"
    threads: 8
    shell: "diamond makedb --in {input} --threads {threads} -d ../results/uniprot_sprot &> {log}"

rule make_diamond_db_uniref90:
    input: rules.download_uniref90.output
    output: "../results/uniref90.dmnd"
    log: "logs/make_diamond_db_uniref90.log"
    benchmark: "benchmark/make_diamond_db_uniref90.txt"
    conda: "../envs/diamond.yaml"
    threads: 8
    shell:  "diamond makedb --in {input} --threads {threads} -d ../results/uniref90 &> {log}"

rule diamond_swissprot:
    input: rules.make_diamond_db_swissprot.output
    params: fa = get_species_fasta
    output: "../results/{species}_IN_swissprot.tsv"
    log: "logs/{species}_IN_swissprot.log"
    benchmark: "benchmark/{species}_IN_swissprot.txt"
    conda: "../envs/diamond.yaml"	
    threads: 8
    shell: "diamond blastp --query {params.fa} --db {input} --out {output} --sensitive --max-target-seqs 300 --evalue 1 --threads {threads} --tmpdir /dev/shm &> {log}"

rule diamond_uniref90:
    input: rules.make_diamond_db_uniref90.output
    params: fa = get_species_fasta
    output: "../results/{species}_IN_uniref90.tsv"
    log: "logs/{species}_IN_uniref90.log"
    benchmark: "benchmark/{species}_IN_uniref90.txt"
    conda: "../envs/diamond.yaml"
    threads: 32
    shell: "diamond blastp --query {params.fa} --db {input} --out {output} --mid-sensitive --max-target-seqs 300 --evalue 1 --threads {threads} --tmpdir /dev/shm &> {log}"
