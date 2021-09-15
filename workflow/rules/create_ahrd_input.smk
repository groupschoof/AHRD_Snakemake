rule create_ahrd_input:
    params:
        fa = get_species_fasta,
        goa = rules.download_goa.output,
        sprot = rules.download_swissprot.output,
        uniref90 = rules.extract_header_and_length_uniref90.output,
        diamondSprot = rules.diamond_swissprot.output,
        diamondUniref90 = rules.diamond_uniref90.output,
        ahrdOutput = "results/{species}.ahrd_output.tsv",
        jar = rules.get_ahrd.output,
        description_settings_token_score_bit_score_weight = config["ahrd"]["description_settings"]["token_score_bit_score_weight"],
        description_settings_token_score_database_score_weight = config["ahrd"]["description_settings"]["token_score_database_score_weight"],
        description_settings_token_score_overlap_score_weight = config["ahrd"]["description_settings"]["token_score_overlap_score_weight"],
        description_settings_blast_dbs_swissprot_weight = config["ahrd"]["description_settings"]["blast_dbs"]["swissprot"]["weight"],
        description_settings_blast_dbs_swissprot_annotation_score_bit_score_weight = config["ahrd"]["description_settings"]["blast_dbs"]["swissprot"]["annotation_score_bit_score_weight"],
        description_settings_blast_dbs_uniref_weight = config["ahrd"]["description_settings"]["blast_dbs"]["uniref"]["weight"],
        description_settings_blast_dbs_uniref_annotation_score_bit_score_weight = config["ahrd"]["description_settings"]["blast_dbs"]["uniref"]["annotation_score_bit_score_weight"],
        go_settings_token_score_bit_score_weight = config["ahrd"]["go_settings"]["token_score_bit_score_weight"],
        go_settings_token_score_database_score_weight = config["ahrd"]["go_settings"]["token_score_database_score_weight"],
        go_settings_token_score_overlap_score_weight = config["ahrd"]["go_settings"]["token_score_overlap_score_weight"],
        go_settings_informative_token_threshold = config["ahrd"]["go_settings"]["informative_token_threshold"],
        go_settings_go_term_score_evidence_code_weight = config["ahrd"]["go_settings"]["go_term_score_evidence_code_weight"],
        go_settings_blast_dbs_swissprot_weight = config["ahrd"]["go_settings"]["blast_dbs"]["swissprot"]["weight"],
        go_settings_blast_dbs_swissprot_annotation_score_bit_score_weight = config["ahrd"]["go_settings"]["blast_dbs"]["swissprot"]["annotation_score_bit_score_weight"],
        go_settings_blast_dbs_uniref_weight = config["ahrd"]["go_settings"]["blast_dbs"]["uniref"]["weight"],
        go_settings_blast_dbs_uniref_annotation_score_bit_score_weight = config["ahrd"]["go_settings"]["blast_dbs"]["uniref"]["annotation_score_bit_score_weight"]
    output: "results/{species}.ahrd_input.yml"
    conda: "../envs/create_ahrd_input.yaml"
    log: "logs/{species}.ahrd_input.log"
    benchmark: "benchmark/{species}.ahrd_input.txt"
    threads: workflow.cores * config["cpu_usage"]["small_jobs"]
    script: "../scripts/yml_generator.R"
