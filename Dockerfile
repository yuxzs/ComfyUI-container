# FROM python:3.11-slim
FROM nvidia/cuda:13.0.2-cudnn-runtime-ubuntu24.04


RUN apt-get update \
    && apt-get install -y \
    python3-full \
    wget \
    git

RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130 --break-system-packages

RUN wget https://raw.githubusercontent.com/comfyanonymous/ComfyUI/refs/heads/master/requirements.txt

RUN wget https://raw.githubusercontent.com/comfyanonymous/ComfyUI/refs/heads/master/manager_requirements.txt

RUN pip install -r requirements.txt --break-system-packages

RUN pip install -r manager_requirements.txt --break-system-packages

RUN python3 --version

# RUN git clone https://github.com/comfyanonymous/ComfyUI.git "/home/sduser/ComfyUI"

# 3. 複製啟動腳本進去
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

WORKDIR /

EXPOSE 8189

# 設定入口點
ENTRYPOINT ["/entrypoint.sh"]
