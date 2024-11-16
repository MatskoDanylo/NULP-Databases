from app import db
from domain.event_artist import EventArtist


def get_all_event_artists():
    return EventArtist.query.all()


def create_event_artist(event_id, artist_id):
    new_event_artist = EventArtist(event_id=event_id, artist_id=artist_id)
    db.session.add(new_event_artist)
    db.session.commit()
    return new_event_artist


def delete_event_artist(event_id, artist_id):
    event_artist = EventArtist.query.filter_by(event_id=event_id, artist_id=artist_id).first()
    if event_artist:
        db.session.delete(event_artist)
        db.session.commit()
