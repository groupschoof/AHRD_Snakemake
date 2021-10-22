rule extract_header_and_length_uniref50:
    input: rules.download_uniref50.output
    output: "resources/uniref50.fasta.tsv.gz"
    log: "logs/extract_header_and_length_uniref50.log"
    benchmark: "benchmark/extract_header_and_length_uniref50.txt"
    conda: "../envs/extract_seq_header_and_length.yaml"
    threads: 4
    shell: "seqkit fx2tab -nl {input} -o {output}"

