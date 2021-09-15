rule extract_header_and_length_uniref90:
    input: rules.download_uniref90.output
    output: "resources/uniref90.fasta.tsv.gz"
    log: "logs/extract_header_and_length_uniref90.log"
    benchmark: "benchmark/extract_header_and_length_uniref90.txt"
    conda: "../envs/extract_seq_header_and_length.yaml"
    threads: 4
    shell: "seqkit fx2tab -nl {input} -o {output}"

