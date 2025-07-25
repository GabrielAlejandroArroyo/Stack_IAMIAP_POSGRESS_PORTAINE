@echo off
echo ========================================
echo    Iniciando servicios Keycloak + WSO2
echo ========================================
echo.

echo [1/5] Verificando Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker no esta instalado o no esta corriendo
    pause
    exit /b 1
)
echo ✓ Docker esta disponible
echo.

echo [2/5] Creando volúmenes externos...
docker volume create keycloak_data >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Volumen keycloak_data creado/verificado
) else (
    echo ✓ Volumen keycloak_data ya existe
)

docker volume create postgres_data >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Volumen postgres_data creado/verificado
) else (
    echo ✓ Volumen postgres_data ya existe
)

docker volume create wso2am_data >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Volumen wso2am_data creado/verificado
) else (
    echo ✓ Volumen wso2am_data ya existe
)

docker volume create portainer_data >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Volumen portainer_data creado/verificado
) else (
    echo ✓ Volumen portainer_data ya existe
)
echo.

echo [3/5] Deteniendo servicios existentes...
docker-compose down >nul 2>&1
echo ✓ Servicios detenidos
echo.

echo [4/5] Iniciando servicios...
docker-compose up -d --force-recreate
if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    ✓ Servicios iniciados correctamente
    echo ========================================
    echo.
    echo URLs de acceso:
    echo • Keycloak: http://localhost:8080
    echo • WSO2 AM Publisher: https://localhost:9443/publisher
    echo • PostgreSQL: localhost:5432
    echo • Portainer: http://localhost:9000
    echo.
    echo Para ver logs: docker-compose logs -f
    echo Para detener: docker-compose down
    echo.
) else (
    echo.
    echo ========================================
    echo    ✗ Error al iniciar servicios
    echo ========================================
    echo.
    echo Revisa los logs con: docker-compose logs
    echo.
)

pause 