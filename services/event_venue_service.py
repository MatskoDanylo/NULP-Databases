from dao import event_venue_dao


def get_all_event_venues():
    return event_venue_dao.get_all_event_venues()


def create_event_venue(event_id, venue_id):
    return event_venue_dao.create_event_venue(event_id, venue_id)


def delete_event_venue(event_id, venue_id):
    return event_venue_dao.delete_event_venue(event_id, venue_id)
