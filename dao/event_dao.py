from domain.artist import Artist
from domain.event import Event
from domain.event_artist import EventArtist
from extensions import db


def get_all_events():
    return Event.query.all()


def get_event_by_id(event_id):
    return Event.query.get(event_id)


def create_event(event_name, event_date, event_time, location, event_type):
    new_event = Event(event_name=event_name, event_date=event_date, event_time=event_time, location=location,
                      event_type=event_type)
    db.session.add(new_event)
    db.session.commit()
    return new_event


def update_event(event_id, event_name, event_date, event_time, location, event_type):
    event = get_event_by_id(event_id)
    if event:
        event.event_name = event_name
        event.event_date = event_date
        event.event_time = event_time
        event.location = location
        event.event_type = event_type
        db.session.commit()
    return event


def delete_event(event_id):
    event = get_event_by_id(event_id)
    if event:
        db.session.delete(event)
        db.session.commit()


def get_artists_by_event(event_id):
    return db.session.query(Artist).join(EventArtist).filter(EventArtist.event_id == event_id).all()
