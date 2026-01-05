#!/bin/bash
set -e

# 定義安裝目錄
INSTALL_DIR="/home/sduser/ComfyUI"

echo "Checking if ComfyUI exists..."

if [ ! -f "$INSTALL_DIR/main.py" ]; then
    echo "ComfyUI not found. Cloning from git..."
    git clone https://github.com/comfyanonymous/ComfyUI.git "$INSTALL_DIR"
else
    echo "ComfyUI found. Skipping clone."
    # 選擇性：每次啟動時自動更新 (如果不需要可註解掉)
    # cd "$INSTALL_DIR" && git pull
fi

cd "$INSTALL_DIR"

# 確保 venv 存在並啟動 (webui.sh 會自動處理，但我們可以在這裡微調)
echo "Launching ComfyUI..."

pip install -r requirements.txt --break-system-packages

# pip install -r manager_requirements.txt --break-system-packages

exec python3 ./main.py

# python main.py --enable-manager
