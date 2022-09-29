rule get_ahrd:
    output: "results/AHRD/dist/ahrd.jar"
    log: "logs/get_ahrd.log"
    benchmark: "benchmark/get_ahrd.txt"
    conda: "../envs/ahrd.yaml"
    params:
        branch=config["ahrd"]["branch"],
    shell:
        "rm -rf results/AHRD/ &> {log};"
        "git clone --branch {params.branch} https://github.com/groupschoof/AHRD.git results/AHRD &>> {log};"
        "cd results/AHRD;"
        "ant dist &>> ../../{log}"
