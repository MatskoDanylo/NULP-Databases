from app import db
from domain.venue import Venue


def get_all_venues():
    return Venue.query.all()


def get_venue_by_id(venue_id):
    return Venue.query.get(venue_id)


def create_venue(venue_name, location, capacity):
    new_venue = Venue(venue_name=venue_name, location=location, capacity=capacity)
    db.session.add(new_venue)
    db.session.commit()
    return new_venue


def update_venue(venue_id, venue_name, location, capacity):
    venue = get_venue_by_id(venue_id)
    if venue:
        venue.venue_name = venue_name
        venue.location = location
        venue.capacity = capacity
        db.session.commit()
    return venue


def delete_venue(venue_id):
    venue = get_venue_by_id(venue_id)
    if venue:
        db.session.delete(venue)
        db.session.commit()
