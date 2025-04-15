# Usa una imagen oficial de Python
FROM python:3.11-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia e instala las dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt



# Copia el resto del código
COPY . .

# Recoge archivos estáticos antes de correr el server
RUN python manage.py collectstatic --noinput

# Expone el puerto (Django usa 8000 por defecto)
EXPOSE 8000

# Comando para arrancar el servidor Django
CMD ["gunicorn", "django_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
