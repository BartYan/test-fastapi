# FROM python:3.9

# COPY requirements.txt app/requirements.txt

# WORKDIR /app

# RUN pip install -r requirements.txt

# COPY . /app

# EXPOSE 8000

# CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8000" , "--reload"]

# Dockerfile

# Określa bazowy obraz Pythona 3.8 z zainstalowanym systemem operacyjnym "Slim" na bazie dystrybucji Debian "Buster".
# Obraz ten zawiera minimalną instalację systemu operacyjnego, Pythona 3.8 i kilka podstawowych narzędzi.
FROM python:3.8-slim-buster

# Tworzy bieżący katalog roboczy wewnątrz kontenera jako "/app"
WORKDIR /app

# Kopiuje całą zawartość katalogu lokalnego do katalogu "/app" wewnątrz kontenera
COPY . .

# Instaluje wymagane biblioteki Pythona, korzystając z pliku "requirements.txt"
RUN pip install -r requirements.txt

# wymusza nasłuchiwanie konkretnego port (nie jest konieczne)
# Dzięki temu, port 8000 w kontenerze zostanie przekierowany na port 8000 w systemie hosta, co umożliwi dostęp do aplikacji z poziomu przeglądarki 
EXPOSE 8000

# Uruchamia serwer FastAPI na porcie 8000, korzystając z serwera ASGI "uvicorn" i pliku "app.py" zawierającego obiekt aplikacji FastAPI
CMD exec uvicorn server:app --host 0.0.0.0 --port 8000 --reload