from dao import ticket_dao


def get_all_tickets():
    return ticket_dao.get_all_tickets()


def get_ticket_by_id(ticket_id):
    return ticket_dao.get_ticket_by_id(ticket_id)


def create_ticket(ticket_number, event_id, price, seat_number, class_type, is_available):
    return ticket_dao.create_ticket(ticket_number, event_id, price, seat_number, class_type, is_available)


def update_ticket(ticket_id, ticket_number, event_id, price, seat_number, class_type, is_available):
    return ticket_dao.update_ticket(ticket_id, ticket_number, event_id, price, seat_number, class_type, is_available)


def delete_ticket(ticket_id):
    return ticket_dao.delete_ticket(ticket_id)
