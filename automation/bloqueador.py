import subprocess
import sys
import threading
import time

# --- CONFIGURACIÓN ---
TIEMPO_BANEO = 60  
WHITELIST = ["127.0.0.1"] # Luego agregamos tu IP de Windows

def desbloquear_ip(ip):
    print(f"[⏳] Esperando {TIEMPO_BANEO}s para desbloquear {ip}...")
    time.sleep(TIEMPO_BANEO)
    comando = f"sudo iptables -D INPUT -s {ip} -j DROP"
    subprocess.run(comando, shell=True)
    print(f"[✅] IP {ip} liberada. El acceso ha sido restaurado.")

def bloquear_ip_seguro(ip_atacante):
    if ip_atacante in WHITELIST:
        print(f"[🛡️] Intento de bloqueo a IP en WHITELIST ({ip_atacante}). Abortando.")
        return

    check_comando = f"sudo iptables -C INPUT -s {ip_atacante} -j DROP"
    block_comando = f"sudo iptables -I INPUT -s {ip_atacante} -j DROP"

    try:
        subprocess.run(check_comando, shell=True, check=True, capture_output=True)
        print(f"[i] La IP {ip_atacante} ya está bloqueada.")
    except subprocess.CalledProcessError:
        try:
            subprocess.run(block_comando, shell=True, check=True)
            print(f"[🔥] NUEVO BLOQUEO: {ip_atacante} por {TIEMPO_BANEO}s.")
            threading.Thread(target=desbloquear_ip, args=(ip_atacante,)).start()
        except Exception as e:
            print(f"[❌] Error: {e}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        bloquear_ip_seguro(sys.argv[1])
    else:
        print("Uso: python3 bloqueador.py <IP>")

