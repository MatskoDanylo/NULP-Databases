from app import db


class DeliveryOption(db.Model):
    __tablename__ = 'delivery_option'
    id = db.Column(db.Integer, primary_key=True)
    delivery_type = db.Column(db.Enum('standard', 'express', 'pickup'))
    cost = db.Column(db.Numeric(5, 2))

    order_deliveries = db.relationship('OrderDelivery', back_populates='delivery_option')
