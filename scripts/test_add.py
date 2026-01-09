import sys, os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from app import app, db, Depense

with app.app_context():
    client = app.test_client()
    resp = client.post('/add', data={'institution':'TestXYZ','recu':'R1','quantite':'1','motif':'Test','date':'2026-01-09','somme':'1000 FC'}, follow_redirects=True)
    print('POST /add status: {}'.format(resp.status_code))
    print('Response length: {}'.format(len(resp.data)))
    count = Depense.query.filter(Depense.institution=='TestXYZ', Depense.recu=='R1').count()
    print('New records count matching test: {}'.format(count))
    print('Response snippet (first 200 bytes):')
    print(resp.data[:200])