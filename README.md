# Arquitectura Serverless por Capas con Terraform (AWS)

Arquitectura serverless de nivel producción utilizando Terraform, AWS Lambda, CodeDeploy y GitHub Actions con despliegues Canary y rollback automático.

---

##  Descripción General

Este proyecto demuestra una arquitectura basada en Infraestructura como Código (IaC) diseñada para realizar despliegues progresivos y seguros en AWS.

El sistema implementa:

- Backend serverless con AWS Lambda (Node.js + TypeScript)
- Infraestructura modularizada con Terraform
- Despliegues Canary usando AWS CodeDeploy
- Rollback automático basado en métricas de CloudWatch
- CI/CD seguro con GitHub Actions usando OIDC (sin credenciales estáticas)

El objetivo es simular un flujo DevOps de nivel producción con despliegues sin tiempo de inactividad.

---

## Arquitectura

Flujo de despliegue:

Git Push  
↓  
GitHub Actions (CI/CD)  
↓  
Build y publicación de nueva versión de Lambda  
↓  
AWS CodeDeploy (Despliegue Canary)  
↓  
Desplazamiento gradual de tráfico mediante Alias  
↓  
Monitoreo con CloudWatch  
↓  
Rollback automático si se detectan errores  

---

## Componentes de Infraestructura

### Estructura por Capas

---

### ☁️ Servicios AWS Utilizados

- AWS Lambda (versionado y alias)
- AWS CodeDeploy (estrategia Blue/Green con Canary)
- AWS DynamoDB (base de datos serverless)
- AWS CloudWatch (monitoreo y alarmas)
- AWS IAM (federación OIDC)
- GitHub Actions (pipeline CI/CD)

---

## Estrategia de Despliegue

El proyecto utiliza **Progressive Delivery**:

1. Cada despliegue publica una nueva versión de Lambda.
2. CodeDeploy redirige el tráfico progresivamente (Canary).
3. CloudWatch monitorea la métrica de errores.
4. Si se supera el umbral configurado, se ejecuta rollback automático.

Esto permite:

Despliegues sin downtime  
Reducción de riesgo en producción  
Recuperación automática ante fallos  

---

## CI/CD Seguro

La autenticación se implementa mediante:

- GitHub OIDC Federation
- IAM Role Assumption
- Sin almacenamiento de claves AWS en el repositorio

Esto elimina el uso de credenciales estáticas y mejora la seguridad del pipeline.

---

## Pipeline CI/CD

Flujo automatizado:

1. Push a la rama `main`
2. GitHub Actions compila el bundle de Lambda
3. Se publica una nueva versión
4. Se crea un despliegue en CodeDeploy
5. Se inicia el despliegue Canary automáticamente

---

## Objetivos Técnicos del Proyecto

Este laboratorio explora:

- Infraestructura como Código (Terraform)
- Arquitectura modular por capas
- Despliegues progresivos (Canary)
- Rollback automático
- Versionado de Lambda
- Autenticación federada segura (OIDC)

---

## Posibles Mejoras Futuras

- Despliegues event-driven con EventBridge
- Promoción multi-entorno (dev → staging → prod)
- Dashboards de observabilidad
- Testing automatizado previo al despliegue

---

## Autor

Proyecto enfocado en prácticas reales de DevOps y Cloud Engineering, simulando patrones utilizados en entornos de producción.
