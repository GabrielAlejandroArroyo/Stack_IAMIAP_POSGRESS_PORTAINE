# Reglas

- Utilizar imágenes oficiales y versiones estables:
  - **Keycloak**: `keycloak/keycloak:22.0.3-0`
  - **WSO2 API Manager**: `wso2/wso2am:4.5.0-rocky`
- Cada servicio en su propio contenedor, conectado a una **red bridge** dedicada (`api-net`) para aislar tráfico interno.
- Persistencia de datos usando **volúmenes nombrados** (`keycloak_data` y `wso2am_data`) para mantener la configuración y credenciales.
- Definir variables de entorno mínimas en un archivo `.env` en el root:
  - Keycloak: `KEYCLOAK_ADMIN`, `KEYCLOAK_ADMIN_PASSWORD`
  - WSO2 AM: `JAVA_OPTS`, `KEYCLOAK_URL`
- Establecer **depends_on** para asegurar orden de arranque (Keycloak antes que WSO2 AM).
- Exponer puertos de administración y acceso público:
  - Keycloak: `8080:8080` (o `8443:8443` si se habilita HTTPS)
  - WSO2 AM: `9443:9443`
- Usar `container_name` para identificar fácilmente los servicios.

# Prompt

```
Genera un archivo docker-compose.yml versión '3.8' que defina dos servicios:
1. keycloak:
   - container_name: keycloak
   - image: keycloak/keycloak:22.0.3-0
   - command: start-dev
   - environment:
       KEYCLOAK_ADMIN: ${KEYCLOAK_ADMIN}
       KEYCLOAK_ADMIN_PASSWORD: ${KEYCLOAK_ADMIN_PASSWORD}
   - volumes:
       - keycloak_data:/opt/keycloak/data
   - ports:
       - "8080:8080"
   - networks:
       - api-net

2. wso2am:
   - container_name: wso2am
   - image: wso2/wso2am:4.5.0-rocky
   - environment:
       JAVA_OPTS: ${JAVA_OPTS}
       KEYCLOAK_URL: ${KEYCLOAK_URL}
   - volumes:
       - wso2am_data:/home/wso2carbon/wso2am-4.5.0/repository/deployment/server
   - ports:
       - "9443:9443"
   - depends_on:
       - keycloak
   - networks:
       - api-net

Define los volúmenes nombrados keycloak_data y wso2am_data, y la red api-net. Incluye comentarios breves sobre cada sección.
```

# Pasos automáticos

1. **Crear archivo `.env` en el root**
   ```env
   KEYCLOAK_ADMIN=admin
   KEYCLOAK_ADMIN_PASSWORD=admin
   JAVA_OPTS=-Xms512m -Xmx1024m
   KEYCLOAK_URL=http://keycloak:8080
   ```
2. **Crear `docker-compose.yml` en el root**
   - Copiar y pegar el contenido generado por el prompt anterior.
   - No es necesario crear manualmente la red ni los volúmenes, docker-compose los gestiona automáticamente.
3. **Levantar los servicios**
   ```bash
   docker-compose up -d --force-recreate
   ```
4. **Verificar**
   - Acceder a Keycloak: `http://localhost:8080`
   - Acceder a WSO2 AM Publisher: `https://localhost:9443/publisher`
   - Configurar en WSO2 AM la federación con Keycloak usando el endpoint `http://keycloak:8080/auth`

