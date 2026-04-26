#!/bin/bash
# 1. Entrar a la carpeta del proyecto
cd ~/Network-Intrusion-Detection-System-LMTM
# 2. Activar el entorno virtual automáticamente
source nids_env/bin/activate
# 3. Ejecutar el monitor de Snort (o el script que prefieras)
python3 automation/monitor_snort.py
