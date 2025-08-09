FROM node:18-bullseye-slim

# Dependencias necesarias para construir sqlite3
RUN apt-get update --fix-missing && \
    apt-get install -y python3 build-essential git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar CLI 0.15.1 y servidor 0.14.0 + sqlite3
RUN npm install -g @lhci/cli@0.15.1 @lhci/server@0.14.0 sqlite3

# Configurar carpeta /data para SQLite
RUN mkdir -p /data && chmod 777 /data
VOLUME ["/data"]

EXPOSE 9001

ENTRYPOINT ["lhci", "server", "--port=9001", "--storage.storageMethod=sql", "--storage.sqlDatabasePath=/data/lhci.db"]
