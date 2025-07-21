# Utiliser une image de base officielle Python slim pour réduire la taille
FROM python:3.11-slim

# Métadonnées
LABEL maintainer="your-email@example.com"
LABEL description="Flask API for book management"
LABEL version="1.0"

# Créer un utilisateur non-privilégié pour la sécurité
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances en premier pour optimiser la mise en cache Docker
COPY requirements.txt pyproject.toml ./

# Installer les dépendances système nécessaires et nettoyer après
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -y gcc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copier le code de l'application
COPY app/ ./app/

# Changer la propriété des fichiers à l'utilisateur non-privilégié
RUN chown -R appuser:appuser /app

# Basculer vers l'utilisateur non-privilégié
USER appuser

# Exposer le port 5000
EXPOSE 5000

# Variables d'environnement pour la production
ENV FLASK_APP=app.main
ENV FLASK_ENV=production
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Commande pour démarrer l'application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]
