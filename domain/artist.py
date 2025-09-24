from extensions import db


class Artist(db.Model):
    __tablename__ = 'artist'
    id = db.Column(db.Integer, primary_key=True)
    artist_name = db.Column(db.String(100), nullable=False)
    artist_type = db.Column(db.Enum('singer', 'band', 'actor', 'train_operator', 'airline'), nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'artist_name': self.artist_name,
            'artist_type': self.artist_type
        }
