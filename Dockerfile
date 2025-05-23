FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

WORKDIR /app


RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt .


RUN pip3 install --no-cache-dir -r requirements.txt


RUN python3 -c "from huggingface_hub import snapshot_download; \
    snapshot_download( \
    repo_id='Intelligent-Internet/II-Medical-7B-Preview', \
    local_dir='/app/model_cache/Intelligent-Internet/II-Medical-7B-Preview' \
    )"


COPY . .


ENV PORT=8080
ENV TRANSFORMERS_CACHE="/app/model_cache"
ENV HF_HOME="/app/model_cache"


EXPOSE 8080


CMD ["python3", "serve.py", "--model-path", "/app/model_cache/Intelligent-Internet/II-Medical-7B-Preview"]
