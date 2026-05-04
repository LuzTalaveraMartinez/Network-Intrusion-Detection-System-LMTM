# 🛡️ Advanced SOC Infrastructure & Active IDS Monitoring - LMTM 2.0

### 👤 Autor: **Luz Maria Talavera Martinez**
**Fecha:** 4 de mayo de 2026 (Actualización de Optimización)
**Especialidad:** Ciberseguridad & Automatización de Infraestructuras

---

![SOC Dashboard LMTM](img/dashboard_soc_lmtm.png)

## 🌟 Visión General del Proyecto
Este ecosistema representa la evolución de un IDS tradicional hacia un **Centro de Operaciones de Seguridad (SOC)** proactivo. Procesa la telemetría de seguridad en múltiples dimensiones para ofrecer visibilidad total sobre la superficie de ataque de un servidor Linux.

---

## 🛠️ Arquitectura del SOC (Defensa en Profundidad)

### 1. NIDS (Snort 2.9.x)
*   **Capacidad:** Análisis de protocolos y detección de firmas maliciosas.
*   **Modo Operativo:** Configurado en **Modo Promiscuo** para inspección total.

### 2. IPS (Fail2ban)
*   **Capacidad:** Respuesta activa ante incidentes y baneo automático.

### 3. HIDS (AIDE)
*   **Capacidad:** Auditoría de integridad de archivos (Host-based).
*   **Estado:** Base de datos inicializada y logs centralizados en `/var/log/aide/`.

### 4. Hardening Audit & Compliance (Lynis)
*   **Métrica:** Sistema auditado y securizado con un **Hardening Index de 83/100**.
*   **Vulnerability Management:** Suscripción **Ubuntu Pro** activa (ESM Apps & Infra) con soporte de seguridad hasta 2036.
*   **Defensa Proactiva:** Kernel protegido con **Livepatch** (parcheo en vivo sin necesidad de reinicio).

---

## 🚀 Ingeniería de Automatización (The SOC Pipeline)

*   **Pipeline de Telemetría (PLG Stack):**
    *   **Promtail:** Transporte de logs optimizado con permisos de sistema.
    *   **Loki:** Almacén de logs indexado por etiquetas.
    *   **Grafana:** Motor de visualización analítica y alertas (Dashboard LMTM v2.0).

*   **Optimización de Infraestructura:** Implementación de rutas absolutas en scripts de despliegue para garantizar portabilidad y resiliencia.

---

## ⚙️ Despliegue Robusto (Quick Start)

1.  **Instalación y Permisos:**
    `sudo ./deploy.sh`
    *(Script optimizado con rutas absolutas y gestión de dependencias).*

2.  **Inicialización HIDS:**
    `sudo aideinit && sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db`
    `sudo aide --check --config /etc/aide/aide.conf | sudo tee /var/log/aide/aide.log`

3.  **Visualización (Docker V2):**
    `cd config && sudo docker compose up -d`
    Acceder a `http://localhost:3000` e importar `dashboards/soc_v2.json`.

---

## 📂 Estructura del Ecosistema
```text
├── config/           # Configuraciones YAML (Promtail, Docker, Lynis)
├── dashboards/       # ADN Visual (Modelos JSON de Grafana)
├── docs/             # Bitácora técnica y reportes de auditoría
├── img/              # Capturas del entorno funcional (Index 83)
├── deploy.sh         # Script maestro corregido (Rutas absolutas)
```

---

**"La seguridad no es un producto, es un proceso automatizado."**
**Desarrollado con precisión por Luz Maria Talavera Martinez** | *Defensa Proactiva.* 🛡️✨
