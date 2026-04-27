# 🛡️ Advanced SOC Infrastructure & Active IDS Monitoring - LMTM 2.0

### 👤 Autor: **Luz Maria Talavera Martinez**
**Fecha:** 26 de abril de 2026  
**Especialidad:** Ciberseguridad & Automatización de Infraestructuras

---

![SOC Dashboard LMTM](img/dashboard_lmtm.png)

## 🌟 Visión General del Proyecto
Este ecosistema representa la evolución de un IDS tradicional hacia un **Centro de Operaciones de Seguridad (SOC)** proactivo. No se limita a capturar paquetes; procesa la telemetría de seguridad en múltiples dimensiones para ofrecer una visibilidad total sobre la superficie de ataque de un servidor Linux.

El desarrollo ha sido optimizado mediante una metodología de **Co-Diseño Humano + IA**, logrando una arquitectura de datos resiliente capaz de operar en hardware optimizado (8GB RAM) sin sacrificar la profundidad del análisis forense.

---

## 🛠️ Arquitectura del SOC (Defensa en Profundidad)

El sistema opera bajo el principio de **Defensa en Capas (Layered Defense)**, cubriendo desde el nivel de red hasta la integridad del kernel:

### 1. NIDS (Network Intrusion Detection System)
*   **Motor:** Snort 2.9.x
*   **Capacidad:** Análisis de protocolos en tiempo real y búsqueda de firmas.
*   **Detección:** Escaneos de puertos (TCP/UDP), Inyección SQL, Cross-Site Scripting (XSS), ataques DoS e ICMP Flooding.

### 2. IPS (Intrusion Prevention System)
*   **Motor:** Fail2ban
*   **Capacidad:** Respuesta activa ante incidentes.
*   **Acción:** Correlación de logs de autenticación (Auth.log) para el baneo automático de IPs mediante reglas de firewall dinámicas tras detectar intentos de fuerza bruta (SSH/HTTP).

### 3. HIDS (Host-based Intrusion Detection System)
*   **Motor:** AIDE (Advanced Intrusion Detection Environment)
*   **Capacidad:** Auditoría de integridad de archivos.
*   **Acción:** Monitoreo de atributos (Mtime, Ctime, Inode, Hash) en directorios críticos (`/etc`, `/bin`, `/sbin`). Detecta modificaciones no autorizadas tras una posible intrusión.

### 4. Firewall Logging (L3/L4)
*   **Motor:** UFW (Uncomplicated Firewall)
*   **Acción:** Centralización de logs de paquetes rechazados/bloqueados para identificar patrones de reconocimiento de red externos.

---

## 🚀 Ingeniería de Automatización (The SOC Pipeline)

Para garantizar que el sistema sea **reproducible en cualquier entorno**, se ha desarrollado un pipeline de despliegue automatizado:

*   **Instalación Maestra (`setup_soc.sh`):** Un script inteligente que verifica pre-requisitos, instala dependencias, configura entornos virtuales de Python (`nids_env`) y descarga binarios de infraestructura (Loki/Promtail) de forma desatendida.
*   **Centralización de Logs (Loki Stack):**
    *   **Promtail:** Actúa como el agente de transporte, raspando logs de `/var/log/snort`, `/var/log/fail2ban.log` y `/var/log/aide/aide.log`.
    *   **Loki:** Almacén de logs de alta eficiencia que indexa metadatos en lugar de contenido completo, permitiendo búsquedas LogQL ultrarrápidas.

---

## 📊 Dashboard Profesional de Grafana

El panel de control ha sido diseñado siguiendo principios de **UX para Analistas SOC**, proporcionando:

*   **Indicadores de Impacto (Stat Panels):** Contadores visuales en rojo (Crítico) y naranja (Advertencia) para alertas de Snort y Fail2ban.
*   **Timeline de Amenazas:** Gráficas de series temporales que muestran picos de actividad sospechosa (como escaneos con Nikto o Nmap).
*   **Consola Forense Unificada:** Un stream de logs en tiempo real que permite ver la anatomía del ataque (IP Origen, Puerto Destino, Mensaje de la Regla) sin salir del navegador.
*   **Integridad de Archivos:** Panel dedicado al reporte de AIDE para visualizar qué archivos fueron modificados tras un incidente.

---

## 📁 Estructura del Ecosistema
```text
├── automation/       # Binarios de infraestructura (Loki/Promtail)
├── configs/          # Configuraciones YAML para el transporte de datos
├── dashboards/       # Modelo JSON del Dashboard (ADN Visual)
├── docs/             # Bitácoras y resúmenes técnicos de ingeniería
├── img/              # Evidencia visual y diagramas
├── scripts/          # Motores de automatización (Setup & Start)
└── requirements.txt  # Dependencias para el análisis de IA/ML
```

---

## ⚙️ Despliegue en 3 Pasos

1.  **Instalación:**
    `cd scripts && sudo ./setup_soc.sh`
2.  **Activación:**
    `./scripts/iniciar_soc.sh`
3.  **Visualización:**
    Importar `dashboards/dashboard_soc.json` en Grafana (`http://localhost:3000`).

---
**"La seguridad no es un producto, es un proceso automatizado."**  
**Desarrollado con precisión por Luz Maria Talavera Martinez** | *Defensa Proactiva & Inteligencia de Seguridad.* 🛡️✨
