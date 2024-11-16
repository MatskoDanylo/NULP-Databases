from app import db


class Ticket(db.Model):
    __tablename__ = 'ticket'
    id = db.Column(db.Integer, primary_key=True)
    ticket_number = db.Column(db.String(50))
    event_id = db.Column(db.Integer, db.ForeignKey('event.id'))
    price = db.Column(db.Numeric(10, 2))
    seat_number = db.Column(db.String(10))
    class_type = db.Column(db.Enum('economy', 'business', 'vip'))
    is_available = db.Column(db.Boolean)

    event = db.relationship('Event', back_populates='tickets')
    order_details = db.relationship('OrderDetail', back_populates='ticket')
