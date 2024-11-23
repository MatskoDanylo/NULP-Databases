from app import db


class EventVenue(db.Model):
    __tablename__ = 'event_venue'
    event_id = db.Column(db.Integer, db.ForeignKey('event.id'), primary_key=True)
    venue_id = db.Column(db.Integer, db.ForeignKey('venue.id'), primary_key=True)

    event = db.relationship('Event', back_populates='event_venues')
    venue = db.relationship('Venue', back_populates='event_venues')
