from dao import event_artist_dao

def get_all_event_artists():
    return event_artist_dao.get_all_event_artists()

def create_event_artist(event_id, artist_id):
    return event_artist_dao.create_event_artist(event_id, artist_id)

def delete_event_artist(event_id, artist_id):
    return event_artist_dao.delete_event_artist(event_id, artist_id)
