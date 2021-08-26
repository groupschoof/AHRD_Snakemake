rule get_ahrd:
    output: "scripts/AHRD/dist/ahrd.jar"
    benchmark: "benchmark/get_ahrd.txt"
    conda: "../envs/get_ahrd.yaml"
    shell:
        "rm -rf scripts/AHRD/;"
        "git clone --branch separate_go_prediction_release https://github.com/groupschoof/AHRD.git scripts/AHRD;"
        "cd scripts/AHRD && ant dist"
