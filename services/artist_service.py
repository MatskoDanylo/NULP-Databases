from dao import artist_dao


def get_all_artists():
    return artist_dao.get_all_artists()


def get_artist_by_id(artist_id):
    return artist_dao.get_artist_by_id(artist_id)


def create_artist(artist_name, artist_type):
    return artist_dao.create_artist(artist_name, artist_type)


def update_artist(artist_id, artist_name, artist_type):
    return artist_dao.update_artist(artist_id, artist_name, artist_type)


def delete_artist(artist_id):
    return artist_dao.delete_artist(artist_id)
