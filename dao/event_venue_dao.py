from app import db
from domain.event_venue import EventVenue


def get_all_event_venues():
    return EventVenue.query.all()


def create_event_venue(event_id, venue_id):
    new_event_venue = EventVenue(event_id=event_id, venue_id=venue_id)
    db.session.add(new_event_venue)
    db.session.commit()
    return new_event_venue


def delete_event_venue(event_id, venue_id):
    event_venue = EventVenue.query.filter_by(event_id=event_id, venue_id=venue_id).first()
    if event_venue:
        db.session.delete(event_venue)
        db.session.commit()
