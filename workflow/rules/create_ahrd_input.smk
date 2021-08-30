rule create_ahrd_input:
    params:
        fa = get_species_fasta,
        goa = rules.download_goa.output,
        sprot = rules.download_swissprot.output,
        uniref90 = rules.download_uniref90.output,
        diamondSprot = rules.diamond_swissprot.output,
        diamondUniref90 = rules.diamond_uniref90.output,
        ahrdOutput = "results/{species}.ahrd_output.tsv",
        jar = rules.get_ahrd.output
    output: "results/{species}.ahrd_input.yml"
    conda: "../envs/create_ahrd_input.yaml"
    log: "logs/{species}.ahrd_input.log"
    benchmark: "benchmark/{species}.ahrd_input.txt"
    script: "../scripts/yml_generator.R"
