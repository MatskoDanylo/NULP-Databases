from app import db
from domain.artist import Artist


def get_all_artists():
    return Artist.query.all()


def get_artist_by_id(artist_id):
    return Artist.query.get(artist_id)


def create_artist(artist_name, artist_type):
    new_artist = Artist(artist_name=artist_name, artist_type=artist_type)
    db.session.add(new_artist)
    db.session.commit()
    return new_artist


def update_artist(artist_id, artist_name, artist_type):
    artist = get_artist_by_id(artist_id)
    if artist:
        artist.artist_name = artist_name
        artist.artist_type = artist_type
        db.session.commit()
    return artist


def delete_artist(artist_id):
    artist = get_artist_by_id(artist_id)
    if artist:
        db.session.delete(artist)
        db.session.commit()
