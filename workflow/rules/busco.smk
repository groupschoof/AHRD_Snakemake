rule busco:
    params: fa = get_species_fasta
    output: "results/{species}_busco"
    log: "logs/{species}_busco.log"
    benchmark: "benchmark/{species}_busco.txt"
    conda: "../envs/busco.yaml"
    shell: "busco -m protein -i {params.fa} -o {output} --auto-lineage &> {log}"
