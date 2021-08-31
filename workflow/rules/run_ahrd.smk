rule run_ahrd:
    input:
        goa = rules.download_goa.output,
        sprot = rules.diamond_swissprot.output,
        uniref = rules.diamond_uniref90.output,
        jar = rules.get_ahrd.output,
        yml = rules.create_ahrd_input.output
    output: "results/{species}.ahrd_output.tsv"
    log: "logs/{species}.ahrd_output.log"
    benchmark: "benchmark/{species}.ahrd_output.txt"
    conda: "../envs/run_ahrd.yaml"
    threads: workflow.cores * config["cpu_usage"]["small_jobs"]
    resources: mem_mb = calc_mem_usage_in_mb
    shell: "java -Xmx{resources.mem_mb}m -jar {input.jar} {input.yml} &> {log}"

