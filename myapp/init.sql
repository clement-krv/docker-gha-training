-- Script d'initialisation pour la base de données myapp_db
-- Ce script sera exécuté automatiquement lors du premier démarrage de PostgreSQL

-- Créer une table pour les livres si elle n'existe pas déjà
CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    year INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insérer quelques données d'exemple
INSERT INTO books (title, author, year) VALUES 
    ('1984', 'George Orwell', 1949),
    ('To Kill a Mockingbird', 'Harper Lee', 1960)
ON CONFLICT DO NOTHING;

-- Créer un index sur le titre pour améliorer les performances
CREATE INDEX IF NOT EXISTS idx_books_title ON books(title);

-- Afficher un message de confirmation
SELECT 'Base de données initialisée avec succès!' as message;
