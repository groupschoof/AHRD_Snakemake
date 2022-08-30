rule run_ProtSpaM:
    input: rules.get_ProtSpaM.output
    output: "results/ProtSpaM.dmat"
    log: "logs/run_ProtSpaM.log"
    benchmark: "benchmark/run_ProtSpaM.txt"
    threads: config["cpu_usage"]["large_jobs"]
    shell:
        "tail -n +2 resources/species.tsv | cut -f 2 >  results/species_Fasta.tsv 2> {log};"
        "{input} -l results/species_Fasta.tsv -t {threads} -o {output} &> {log}"
