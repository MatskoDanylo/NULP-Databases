from dao import order_dao


def get_all_orders():
    return order_dao.get_all_orders()


def get_orders_by_customer(customer_id):
    return order_dao.get_orders_by_customer(customer_id)


def get_order_by_id(order_id):
    return order_dao.get_order_by_id(order_id)


def create_order(customer_id, order_date, total_price, payment_status):
    return order_dao.create_order(customer_id, order_date, total_price, payment_status)


def update_order(order_id, customer_id, order_date, total_price, payment_status):
    return order_dao.update_order(order_id, customer_id, order_date, total_price, payment_status)


def delete_order(order_id):
    return order_dao.delete_order(order_id)
