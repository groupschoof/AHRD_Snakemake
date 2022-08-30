rule get_ProtSpaM:
    output: "results/ProtSpaM/bin/Debug/protspam"
    log: "logs/get_ProtSpaM.log"
    benchmark: "benchmark/get_ProtSpaM.txt"
    conda: "../envs/get_ProtSpaM.yaml"
    shell:
        "rm -rf results/ProtSpaM/ &> {log};"
        "git clone https://github.com/jschellh/ProtSpaM.git results/ProtSpaM &>> {log};"
        "cd results/ProtSpaM;"
        "make &>> ../../{log}"
