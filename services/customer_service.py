from dao import customer_dao


def get_all_customers():
    return customer_dao.get_all_customers()


def get_customer_by_id(customer_id):
    return customer_dao.get_customer_by_id(customer_id)


def create_customer(first_name, last_name, email, phone):
    return customer_dao.create_customer(first_name, last_name, email, phone)


def update_customer(customer_id, first_name, last_name, email, phone):
    return customer_dao.update_customer(customer_id, first_name, last_name, email, phone)


def delete_customer(customer_id):
    return customer_dao.delete_customer(customer_id)
