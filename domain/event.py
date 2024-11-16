from extensions import db


class Event(db.Model):
    __tablename__ = 'event'
    id = db.Column(db.Integer, primary_key=True)
    event_name = db.Column(db.String(100), nullable=False)
    event_date = db.Column(db.Date, nullable=False)
    event_time = db.Column(db.Time, nullable=False)
    location = db.Column(db.String(100), nullable=False)
    event_type = db.Column(db.Enum('concert', 'theater', 'train', 'flight'), nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'event_name': self.event_name,
            'event_date': str(self.event_date),
            'event_time': str(self.event_time),
            'location': self.location,
            'event_type': self.event_type
        }
