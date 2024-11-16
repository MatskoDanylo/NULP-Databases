from dao import event_dao


def get_all_events():
    return event_dao.get_all_events()


def get_event_by_id(event_id):
    return event_dao.get_event_by_id(event_id)


def create_event(event_name, event_date, event_time, location, event_type):
    return event_dao.create_event(event_name, event_date, event_time, location, event_type)


def update_event(event_id, event_name, event_date, event_time, location, event_type):
    return event_dao.update_event(event_id, event_name, event_date, event_time, location, event_type)


def delete_event(event_id):
    return event_dao.delete_event(event_id)


def get_artists_by_event(event_id):
    return event_dao.get_artists_by_event(event_id)
