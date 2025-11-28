# Dockerfile
FROM eclipse-mosquitto:latest


# Copiar configuración de Mosquitto
 COPY config/mosquitto.conf /mosquitto/config/mosquitto.conf

# Puerto para MQTT
EXPOSE 1883

# Comando por defecto
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]


#encontrar dir del mqtt
# docker build -t mi-mosquitto .
# docker run -d -p 1883:1883 --name mosquitto-container mi-mosquitto
# docker ps

