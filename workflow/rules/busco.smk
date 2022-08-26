rule busco:
    params: fa = get_species_fasta
    output: directory("results/{species}_busco")
    log: "logs/{species}_busco.log"
    benchmark: "benchmark/{species}_busco.txt"
    conda: "../envs/busco.yaml"
    threads: config["cpu_usage"]["large_jobs"]
    shell: "busco -m protein -i {params.fa} -o {output} --cpu {threads} --auto-lineage &> {log}"
