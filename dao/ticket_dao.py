from app import db
from domain.ticket import Ticket


def get_all_tickets():
    return Ticket.query.all()


def get_ticket_by_id(ticket_id):
    return Ticket.query.get(ticket_id)


def create_ticket(ticket_number, event_id, price, seat_number, class_type, is_available):
    new_ticket = Ticket(ticket_number=ticket_number, event_id=event_id, price=price, seat_number=seat_number,
                        class_type=class_type, is_available=is_available)
    db.session.add(new_ticket)
    db.session.commit()
    return new_ticket


def update_ticket(ticket_id, ticket_number, event_id, price, seat_number, class_type, is_available):
    ticket = get_ticket_by_id(ticket_id)
    if ticket:
        ticket.ticket_number = ticket_number
        ticket.event_id = event_id
        ticket.price = price
        ticket.seat_number = seat_number
        ticket.class_type = class_type
        ticket.is_available = is_available
        db.session.commit()
    return ticket


def delete_ticket(ticket_id):
    ticket = get_ticket_by_id(ticket_id)
    if ticket:
        db.session.delete(ticket)
        db.session.commit()
