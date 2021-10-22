rule download_oryza:
    output: "resources/Oryza_sativa.IRGSP-1.0.pep.all.fa"
    log: "logs/download_oryza.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_oryza.txt"
    shell:
        "aria2c ftp://ftp.ensemblgenomes.org/pub/release-51/plants/fasta/oryza_sativa/pep/Oryza_sativa.IRGSP-1.0.pep.all.fa.gz --dir=resources &> {log};"
        "gunzip resources/Oryza_sativa.IRGSP-1.0.pep.all.fa.gz &>> {log}"

rule download_swissprot:
    output: "resources/uniprot_sprot.fasta.gz"
    log: "logs/download_swissprot.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_swissprot.txt"
    shell:
        "aria2c https://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2021_02/knowledgebase/RELEASE.metalink --follow-metalink=mem --select-file=4 --file-allocation=none --dir=resources &> {log};"
        "tar -zxvf resources/uniprot_sprot-only2021_02.tar.gz uniprot_sprot.fasta.gz --one-top-level=resources &>> {log};"
        "rm resources/uniprot_sprot-only2021_02.tar.gz &>> {log};"

rule download_uniref50:
    output: "resources/uniref50.fasta.gz"
    log: "logs/download_uniref50.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_uniref50.txt"
    shell:
        "aria2c https://ftp.uniprot.org/pub/databases/uniprot/previous_releases/release-2021_02/uniref/RELEASE.metalink --follow-metalink=mem --select-file=4 --file-allocation=none --dir=resources &> {log};"
        "tar -zxvf resources/uniref2021_02.tar.gz uniref50.tar --one-top-level=resources &>> {log};"
        "rm resources/uniref2021_02.tar.gz &>> {log};"
        "tar -xvf resources/uniref50.tar uniref50.xml.gz --to-stdout | gunzip | workflow/scripts/unirefxml2fasta.py - --gzip-output -o resources/uniref50.fasta.gz &>> {log};"

rule download_goa:
    output: "resources/goa_uniprot_all.gaf.203.gz"
    log: "logs/download_goa.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_goa.txt"
    shell:
        "aria2c https://ftp.ebi.ac.uk/pub/databases/GO/goa/old/UNIPROT/goa_uniprot_all.gaf.203.gz --file-allocation=none --dir=resources &> {log};"
