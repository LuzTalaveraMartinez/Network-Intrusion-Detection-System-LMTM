import subprocess
import time
import re
import threading
import signal
import sys

# --- CONFIGURACIÓN ---
LOG_SNORT = "/var/log/snort/alert"  # Asegúrate de que esta sea tu ruta
TIEMPO_BANEO = 300  # 5 minutos para que se note en el proyecto
WHITELIST = ["127.0.0.1", "192.168.1.1"] # Agregaremos tu IP de Windows después

def desbloquear_ip(ip):
    time.sleep(TIEMPO_BANEO)
    subprocess.run(f"sudo iptables -D INPUT -s {ip} -j DROP", shell=True)
    print(f"[✅] Bloqueo expirado: {ip} ahora es libre.")

def bloquear_ip(ip):
    if ip in WHITELIST:
        return
    
    # Verificar si ya está bloqueada para no repetir
    check = subprocess.run(f"sudo iptables -C INPUT -s {ip} -j DROP", shell=True, capture_output=True)
    if check.returncode != 0:
        subprocess.run(f"sudo iptables -I INPUT -s {ip} -j DROP", shell=True)
        print(f"[🔥] IPS LMTM: Atacante {ip} bloqueado por {TIEMPO_BANEO}s")
        threading.Thread(target=desbloquear_ip, args=(ip,)).start()

def monitor_snort():
    print(f"[👀] Vigilando Snort en {LOG_SNORT}...")
    # El comando tail -f lee el archivo en tiempo real
    proceso = subprocess.Popen(["tail", "-f", LOG_SNORT], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    
    # Expresión regular para encontrar IPs en el log de Snort
    # Snort suele loguear: {TCP} 192.168.1.50:1234 -> 192.168.1.10:80
    ip_regex = re.compile(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')

    try:
        for linea in proceso.stdout:
            # Buscamos la primera IP que aparece (suele ser el atacante)
            ips = ip_regex.findall(linea)
            if ips:
                ip_atacante = ips[0]
                bloquear_ip(ip_atacante)
    except KeyboardInterrupt:
        proceso.terminate()

if __name__ == "__main__":
    print("--- SISTEMA DE DEFENSA ACTIVA LMTM INICIADO ---")
    monitor_snort()
