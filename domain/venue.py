from app import db


class Venue(db.Model):
    __tablename__ = 'venue'
    id = db.Column(db.Integer, primary_key=True)
    venue_name = db.Column(db.String(100))
    location = db.Column(db.String(100))
    capacity = db.Column(db.Integer)

    event_venues = db.relationship('EventVenue', back_populates='venue')
