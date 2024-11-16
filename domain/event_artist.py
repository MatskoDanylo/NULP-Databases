from extensions import db


class EventArtist(db.Model):
    __tablename__ = 'event_artist'
    event_id = db.Column(db.Integer, db.ForeignKey('event.id'), primary_key=True)
    artist_id = db.Column(db.Integer, db.ForeignKey('artist.id'), primary_key=True)

    def to_dict(self):
        return {
            'event_id': self.event_id,
            'artist_id': self.artist_id
        }
