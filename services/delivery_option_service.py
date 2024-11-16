from dao import delivery_option_dao


def get_all_delivery_options():
    return delivery_option_dao.get_all_delivery_options()


def get_delivery_option_by_id(option_id):
    return delivery_option_dao.get_delivery_option_by_id(option_id)


def create_delivery_option(delivery_type, cost):
    return delivery_option_dao.create_delivery_option(delivery_type, cost)


def update_delivery_option(option_id, delivery_type, cost):
    return delivery_option_dao.update_delivery_option(option_id, delivery_type, cost)


def delete_delivery_option(option_id):
    return delivery_option_dao.delete_delivery_option(option_id)
