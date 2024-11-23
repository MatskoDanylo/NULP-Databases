from domain.customer import Customer
from extensions import db


def get_all_customers():
    return Customer.query.all()


def get_customer_by_id(customer_id):
    return Customer.query.get(customer_id)


def create_customer(first_name, last_name, email, phone):
    new_customer = Customer(first_name=first_name, last_name=last_name, email=email, phone=phone)
    db.session.add(new_customer)
    db.session.commit()
    return new_customer


def update_customer(customer_id, first_name, last_name, email, phone):
    customer = get_customer_by_id(customer_id)
    if customer:
        customer.first_name = first_name
        customer.last_name = last_name
        customer.email = email
        customer.phone = phone
        db.session.commit()
    return customer


def delete_customer(customer_id):
    customer = get_customer_by_id(customer_id)
    if customer:
        db.session.delete(customer)
        db.session.commit()
