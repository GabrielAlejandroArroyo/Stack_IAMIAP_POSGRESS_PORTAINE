@echo off
echo ========================================
echo    Estado de servicios Keycloak + WSO2
echo ========================================
echo.

echo [1/3] Verificando contenedores...
docker-compose ps
echo.

echo [2/3] Verificando volúmenes...
docker volume ls --format "table {{.Name}}\t{{.Driver}}" | findstr "keycloak_data\|postgres_data\|wso2am_data\|portainer_data"
echo.

echo [3/3] Verificando puertos...
netstat -an | findstr ":8080\|:9443\|:5432\|:9000"
echo.

echo ========================================
echo    URLs de acceso:
echo • Keycloak: http://localhost:8080
echo • WSO2 AM Publisher: https://localhost:9443/publisher
echo • PostgreSQL: localhost:5432
echo • Portainer: http://%PORTAINER_HOST%:%PORTAINER_PORT%
echo ========================================
echo.

pause 