FROM condaforge/mambaforge:latest
LABEL io.github.snakemake.containerized="true"
LABEL io.github.snakemake.conda_env_hash="dee6e7b36becec444502ecdbc27760da2fd255380e746bafe661248b6f2c8696"

# Step 1: Retrieve conda environments

# Conda environment:
#   source: workflow/envs/ahrd.yaml
#   prefix: /conda-envs/b891df5cf0bda1a184e44c65e140687c
#   channels:
#     - conda-forge
#     - bioconda
#   dependencies:
#     - "git>=2.30.2"
#     - "ant>=1.10.0"
#     - "openjdk>=8.0.112"
RUN mkdir -p /conda-envs/b891df5cf0bda1a184e44c65e140687c
COPY workflow/envs/ahrd.yaml /conda-envs/b891df5cf0bda1a184e44c65e140687c/environment.yaml

# Conda environment:
#   source: workflow/envs/create_ahrd_input.yaml
#   prefix: /conda-envs/7302face015ee15709f2aa60d19249d0
#   channels:
#     - conda-forge
#   dependencies:
#     - "r-base>=4.1.0"
RUN mkdir -p /conda-envs/7302face015ee15709f2aa60d19249d0
COPY workflow/envs/create_ahrd_input.yaml /conda-envs/7302face015ee15709f2aa60d19249d0/environment.yaml

# Conda environment:
#   source: workflow/envs/diamond.yaml
#   prefix: /conda-envs/bfaaae07cc4b0f8e16b525bbed678ffd
#   channels:
#     - conda-forge
#     - bioconda
#   dependencies:
#     - "diamond>=2.0.9"
RUN mkdir -p /conda-envs/bfaaae07cc4b0f8e16b525bbed678ffd
COPY workflow/envs/diamond.yaml /conda-envs/bfaaae07cc4b0f8e16b525bbed678ffd/environment.yaml

# Conda environment:
#   source: workflow/envs/download.yaml
#   prefix: /conda-envs/12405ac7c6a9b863d138d4734e929ddf
#   channels:
#     - conda-forge
#     - bioconda
#   dependencies:
#     - "aria2>=1.34.0"
RUN mkdir -p /conda-envs/12405ac7c6a9b863d138d4734e929ddf
COPY workflow/envs/download.yaml /conda-envs/12405ac7c6a9b863d138d4734e929ddf/environment.yaml

# Conda environment:
#   source: workflow/envs/extract_seq_header_and_length.yaml
#   prefix: /conda-envs/8b73dbc695fa3c1b910112cc6012e920
#   channels:
#     - conda-forge
#     - bioconda
#   dependencies:
#     - "seqkit>=2.0.0"
RUN mkdir -p /conda-envs/8b73dbc695fa3c1b910112cc6012e920
COPY workflow/envs/extract_seq_header_and_length.yaml /conda-envs/8b73dbc695fa3c1b910112cc6012e920/environment.yaml

# Step 2: Generate conda environments

RUN mamba env create --prefix /conda-envs/b891df5cf0bda1a184e44c65e140687c --file /conda-envs/b891df5cf0bda1a184e44c65e140687c/environment.yaml && \
    mamba env create --prefix /conda-envs/7302face015ee15709f2aa60d19249d0 --file /conda-envs/7302face015ee15709f2aa60d19249d0/environment.yaml && \
    mamba env create --prefix /conda-envs/bfaaae07cc4b0f8e16b525bbed678ffd --file /conda-envs/bfaaae07cc4b0f8e16b525bbed678ffd/environment.yaml && \
    mamba env create --prefix /conda-envs/12405ac7c6a9b863d138d4734e929ddf --file /conda-envs/12405ac7c6a9b863d138d4734e929ddf/environment.yaml && \
    mamba env create --prefix /conda-envs/8b73dbc695fa3c1b910112cc6012e920 --file /conda-envs/8b73dbc695fa3c1b910112cc6012e920/environment.yaml && \
    mamba clean --all -y
