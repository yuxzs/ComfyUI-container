# FROM python:3.11-slim
FROM nvidia/cuda:13.0.2-cudnn-runtime-ubuntu24.04

ENV PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/home/sduser/ComfyUI/venv \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
    python3-full \
    pip \
    wget \
    git

RUN git clone https://github.com/comfyanonymous/ComfyUI.git "/home/sduser/ComfyUI"
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python3 --version
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130

# RUN wget https://raw.githubusercontent.com/comfyanonymous/ComfyUI/refs/heads/master/requirements.txt

# RUN wget https://raw.githubusercontent.com/comfyanonymous/ComfyUI/refs/heads/master/manager_requirements.txt


RUN pip install -r /home/sduser/ComfyUI/requirements.txt 
RUN pip install -r /home/sduser/ComfyUI/manager_requirements.txt

# 3. 複製啟動腳本進去
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

WORKDIR /

EXPOSE 8189

# 設定入口點
ENTRYPOINT ["/entrypoint.sh"]
