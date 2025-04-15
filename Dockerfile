# Usa una imagen oficial de Python
FROM python:3.11-slim

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev gcc build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Establece directorio de trabajo
WORKDIR /app

# Copia requirements e instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del proyecto
COPY . .

# Ejecuta collectstatic (puedes mover esto a Render si da problemas)
RUN python manage.py collectstatic --noinput

# Expone el puerto
EXPOSE 8000

# Comando para producción con gunicorn
CMD ["gunicorn", "django_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
