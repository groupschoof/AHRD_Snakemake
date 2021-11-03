rule download_ecoli:
    output: "resources/Escherichia_coli_str_k_12_substr_mg1655_gca_000005845.ASM584v2.pep.all.fa"
    log: "logs/download_ecoli.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_ecoli.txt"
    shell:
        "aria2c ftp://ftp.ensemblgenomes.org/pub/release-51/bacteria/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655_gca_000005845/pep/Escherichia_coli_str_k_12_substr_mg1655_gca_000005845.ASM584v2.pep.all.fa.gz --dir=resources &> {log};"
        "gunzip resources/Escherichia_coli_str_k_12_substr_mg1655_gca_000005845.ASM584v2.pep.all.fa.gz &>> {log}"

rule download_swissprot:
    output: "resources/uniprot_sprot.fasta"
    log: "logs/download_swissprot.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_swissprot.txt"
    shell:
        "aria2c https://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2021_02/knowledgebase/RELEASE.metalink --follow-metalink=mem --select-file=4 --file-allocation=none --dir=resources &> {log};"
        "tar -zxvf resources/uniprot_sprot-only2021_02.tar.gz uniprot_sprot.fasta.gz --one-top-level=resources &>> {log};"
        "rm resources/uniprot_sprot-only2021_02.tar.gz &>> {log};"
        "gunzip resources/uniprot_sprot.fasta.gz &>> {log};"

rule download_uniref50:
    output: "resources/uniref50.fasta"
    log: "logs/download_uniref50.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_uniref50.txt"
    shell:
        "aria2c https://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2021_02/uniref/RELEASE.metalink --follow-metalink=mem --select-file=4 --file-allocation=none --dir=resources &> {log};"
        "tar -zxvf resources/uniref2021_02.tar.gz uniref50.tar --one-top-level=resources &>> {log};"
        "rm resources/uniref2021_02.tar.gz &>> {log};"
        "tar -xvf resources/uniref50.tar uniref50.xml.gz --to-stdout | gunzip | workflow/scripts/unirefxml2fasta.py - -o resources/uniref50.fasta &>> {log};"

rule download_goa:
    output: "resources/goa_uniprot_all.gaf.203.gz"
    log: "logs/download_goa.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_goa.txt"
    shell:
        "aria2c https://ftp.ebi.ac.uk/pub/databases/GO/goa/old/UNIPROT/goa_uniprot_all.gaf.203.gz --file-allocation=none --dir=resources &> {log};"
