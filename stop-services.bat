@echo off
echo ========================================
echo    Deteniendo servicios Keycloak + WSO2
echo ========================================
echo.

echo [1/2] Deteniendo servicios...
docker-compose down
if %errorlevel% equ 0 (
    echo ✓ Servicios detenidos correctamente
) else (
    echo ✗ Error al detener servicios
)
echo.

echo [2/2] Limpiando volúmenes no utilizados...
docker volume prune -f >nul 2>&1
echo ✓ Limpieza completada
echo.

echo ========================================
echo    ✓ Proceso completado
echo ========================================
echo.
echo Para volver a iniciar: ejecuta start-services.bat
echo.

pause 