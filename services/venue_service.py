from dao import venue_dao


def get_all_venues():
    return venue_dao.get_all_venues()


def get_venue_by_id(venue_id):
    return venue_dao.get_venue_by_id(venue_id)


def create_venue(venue_name, location, capacity):
    return venue_dao.create_venue(venue_name, location, capacity)


def update_venue(venue_id, venue_name, location, capacity):
    return venue_dao.update_venue(venue_id, venue_name, location, capacity)


def delete_venue(venue_id):
    return venue_dao.delete_venue(venue_id)
