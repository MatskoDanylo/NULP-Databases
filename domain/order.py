from extensions import db


class Order(db.Model):
    __tablename__ = 'order'
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.id'), nullable=False)
    order_date = db.Column(db.Date, nullable=False)
    total_price = db.Column(db.Numeric(10, 2), nullable=False)
    payment_status = db.Column(db.Enum('paid', 'pending', 'failed', 'cancelled'), nullable=False)


    customer = db.relationship('Customer', back_populates='orders')

    def to_dict(self):
        return {
            'id': self.id,
            'customer_id': self.customer_id,
            'order_date': str(self.order_date),
            'total_price': str(self.total_price),
            'payment_status': self.payment_status
        }
