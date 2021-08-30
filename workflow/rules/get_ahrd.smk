rule get_ahrd:
    output: "results/AHRD/dist/ahrd.jar"
    log: "logs/get_ahrd.log"
    benchmark: "benchmark/get_ahrd.txt"
    conda: "../envs/get_ahrd.yaml"
    shell:
        "rm -rf results/AHRD/ &> {log};"
        "git clone --branch separate_go_prediction_release https://github.com/groupschoof/AHRD.git results/AHRD &>> {log};"
        "cd results/AHRD;"
        "ant dist &>> ../../{log}"
