# Keycloak + WSO2 API Manager con PostgreSQL

Este proyecto configura un entorno completo con Keycloak para autenticación y WSO2 API Manager, usando PostgreSQL como base de datos, e incluye Portainer para gestión web de Docker.

## Servicios incluidos

- **PostgreSQL 15**: Base de datos para Keycloak
- **Keycloak 22.0.3**: Servidor de autenticación y gestión de identidades
- **WSO2 API Manager 4.5.0**: Gestión de APIs
- **Portainer CE**: Interfaz web para gestión de contenedores Docker

## Scripts de Windows

### 🚀 start-services.bat
Inicia todos los servicios automáticamente:
- Verifica que Docker esté disponible
- Crea los volúmenes externos necesarios
- Detiene servicios existentes
- Inicia todos los servicios con docker-compose

**Uso:** Doble clic en `start-services.bat`

### 🛑 stop-services.bat
Detiene todos los servicios de forma limpia:
- Detiene todos los contenedores
- Limpia volúmenes no utilizados

**Uso:** Doble clic en `stop-services.bat`

### 📊 check-status.bat
Verifica el estado de todos los servicios:
- Muestra el estado de los contenedores
- Lista los volúmenes creados
- Verifica los puertos en uso

**Uso:** Doble clic en `check-status.bat`

## URLs de acceso

- **Keycloak**: http://localhost:8080
- **WSO2 AM Publisher**: https://localhost:9443/publisher
- **PostgreSQL**: localhost:5432
- **Portainer**: http://localhost:9000

## Configuración

### Variables de entorno (.env)
```env
# Variables sensibles para Keycloak
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin

# Variables para WSO2 AM
JAVA_OPTS=-Xms512m -Xmx1024m
KEYCLOAK_URL=http://keycloak:8080

# Variables para PostgreSQL
POSTGRES_DB=keycloak
POSTGRES_USER=keycloak
POSTGRES_PASSWORD=keycloak_password
POSTGRES_HOST=postgres
POSTGRES_PORT=5432

# Variables para Portainer
PORTAINER_ADMIN_USER=admin
PORTAINER_ADMIN_PASSWORD=admin123
PORTAINER_HOST=localhost
PORTAINER_PORT=9000
```

## Volúmenes

Los datos se almacenan en volúmenes Docker externos:
- `keycloak_data`: Datos de Keycloak
- `postgres_data`: Base de datos PostgreSQL
- `wso2am_data`: Datos de WSO2 API Manager
- `portainer_data`: Datos de Portainer

## Comandos útiles

```bash
# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs keycloak
docker-compose logs postgres
docker-compose logs wso2am
docker-compose logs portainer

# Reiniciar un servicio específico
docker-compose restart keycloak

# Ver estado de los servicios
docker-compose ps

# Acceder al shell de un contenedor
docker-compose exec keycloak /bin/bash
docker-compose exec postgres psql -U keycloak -d keycloak
```

## Gestión con Portainer

Portainer proporciona una interfaz web para gestionar todos los contenedores Docker:

1. **Acceder a Portainer**: http://localhost:9000
2. **Configuración inicial**: 
   - Crear usuario administrador
   - Seleccionar "Local Docker Environment"
3. **Funcionalidades disponibles**:
   - Ver todos los contenedores en tiempo real
   - Ver logs de contenedores
   - Reiniciar/parar contenedores
   - Gestionar volúmenes y redes
   - Monitorear uso de recursos

## Solución de problemas

### Error de volúmenes externos
Si aparece el error "external volume not found", ejecuta:
```bash
docker volume create keycloak_data
docker volume create postgres_data
docker volume create wso2am_data
docker volume create portainer_data
```

### Puerto ocupado
Si algún puerto está ocupado, detén el servicio que lo use o cambia el puerto en `docker-compose.yml`.

### Problemas de SSL en WSO2
WSO2 AM usa HTTPS por defecto. Si hay problemas de certificados, puedes acceder usando `http://localhost:9443` temporalmente.

### Acceso a Portainer
Si no puedes acceder a Portainer, verifica que el puerto 9000 no esté ocupado por otro servicio.

## Requisitos

- Docker Desktop para Windows
- Docker Compose
- Al menos 4GB de RAM disponible 