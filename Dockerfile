# Usa imagen oficial de Python
FROM python:3.11-slim

# Setea el directorio de trabajo
WORKDIR /app

# Instala dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de la app
COPY . .

# Establecer variables de entorno
ENV SECRET_KEY=django-insecure-t3nm=4=@#fr&i(*smg78nfq*bvhh$zn6sg#mk#!yp%_8ykl+xp
ENV DEBUG=False
ENV DATABASE_URL=postgresql://ziondb_user:THC2NGkg5n3yQqYmDI51AiDukGkRgKrS@dpg-cvuqtsidbo4c73f620gg-a.oregon-postgres.render.com/ziondb

# Ejecutar collectstatic
RUN python manage.py collectstatic --noinput

# Expón el puerto
EXPOSE 8000

# Comando para correr la app
CMD ["gunicorn", "django_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
