# FROM python:3.11-slim
FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04


RUN apt-get update && apt-get install -y \
    python3.13 python3.13-venv pip \
    wget git 

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130

# 3. 複製啟動腳本進去
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

WORKDIR /

EXPOSE 8189

# 設定入口點
ENTRYPOINT ["/entrypoint.sh"]