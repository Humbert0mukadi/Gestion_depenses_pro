# Gestion des Dépenses

Application Flask pour gérer les dépenses médicales :
- Ajout, modification, suppression de lignes
- Calcul automatique du total
- Export en Word et PDF
- Interface Bootstrap moderne

## Déploiement
- Installer les dépendances : `pip install -r requirements.txt`
- Lancer en local : `python app.py`
- Déploiement Render : `gunicorn -b 0.0.0.0:$PORT app:app`