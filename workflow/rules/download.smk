rule download_swissprot:
    output: "resources/uniprot_sprot.fasta.gz"
    log: "logs/download_swissprot.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_swissprot.txt"
    shell: "aria2c https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/RELEASE.metalink --follow-metalink=mem --select-file=6 --file-allocation=none --dir=resources &>{log}"

rule download_uniref90:
    output: "resources/uniref90.fasta.gz"
    log: "logs/download_uniref90.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_uniref90.txt"
    shell: "aria2c https://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/uniref90/RELEASE.metalink --follow-metalink=mem --select-file=5 --file-allocation=none --dir=resources &>{log}"

rule download_goa:
    output: "resources/goa_uniprot_all.gaf.gz"
    log: "logs/download_goa.log"
    conda: "../envs/download.yaml"
    benchmark: "benchmark/download_goa.txt"
#    shell: "wget -nv --no-check-certificate -P ../resources/ https://ftp.ebi.ac.uk/pub/databases/GO/goa/UNIPROT/goa_uniprot_all.gaf.gz -o {log}"
#    shell: "wget -nv -P ../resources/ http://current.geneontology.org/annotations/goa_uniprot_all.gaf.gz -o {log}"
    shell: "aria2c https://ftp.ebi.ac.uk/pub/databases/GO/goa/UNIPROT/goa_uniprot_all.gaf.gz http://current.geneontology.org/annotations/goa_uniprot_all.gaf.gz --file-allocation=none --dir=resources &>{log}"
