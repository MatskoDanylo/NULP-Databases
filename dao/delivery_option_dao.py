from app import db
from domain.delivery_option import DeliveryOption


def get_all_delivery_options():
    return DeliveryOption.query.all()


def get_delivery_option_by_id(option_id):
    return DeliveryOption.query.get(option_id)


def create_delivery_option(delivery_type, cost):
    new_option = DeliveryOption(delivery_type=delivery_type, cost=cost)
    db.session.add(new_option)
    db.session.commit()
    return new_option


def update_delivery_option(option_id, delivery_type, cost):
    option = get_delivery_option_by_id(option_id)
    if option:
        option.delivery_type = delivery_type
        option.cost = cost
        db.session.commit()
    return option


def delete_delivery_option(option_id):
    option = get_delivery_option_by_id(option_id)
    if option:
        db.session.delete(option)
        db.session.commit()
