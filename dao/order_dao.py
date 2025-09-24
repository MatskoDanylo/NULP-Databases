from domain.order import Order
from extensions import db


def get_all_orders():
    return Order.query.all()


def get_orders_by_customer(customer_id):
    # Фільтрація замовлень за customer_id
    return Order.query.filter_by(customer_id=customer_id).all()


def get_order_by_id(order_id):
    return Order.query.get(order_id)


def create_order(customer_id, order_date, total_price, payment_status):
    new_order = Order(customer_id=customer_id, order_date=order_date, total_price=total_price,
                      payment_status=payment_status)
    db.session.add(new_order)
    db.session.commit()
    return new_order


def update_order(order_id, customer_id, order_date, total_price, payment_status):
    order = get_order_by_id(order_id)
    if order:
        order.customer_id = customer_id
        order.order_date = order_date
        order.total_price = total_price
        order.payment_status = payment_status
        db.session.commit()
    return order


def delete_order(order_id):
    order = get_order_by_id(order_id)
    if order:
        db.session.delete(order)
        db.session.commit()
