# Ejemplo rápido de concepto
import time

log_path = "/var/log/snort/alert"

with open(log_path, "r") as f:
    f.seek(0, 2) # Ir al final del archivo
    while True:
        line = f.readline()
        if not line:
            time.sleep(0.1)
            continue
        if "ESCANEO DETECTADO" in line:
            print("!!! ATENCIÓN: ¡Alguien nos está escaneando!")
            # Aquí podrías añadir código para bloquear la IP automáticamente
