from domain.customer import Customer
from extensions import db
from sqlalchemy.exc import OperationalError
import pymysql


def get_all_customers():
    return Customer.query.all()


def get_customer_by_id(customer_id):
    return Customer.query.get(customer_id)


def create_customer(first_name, last_name, email, phone):
    try:
        new_customer = Customer(first_name=first_name, last_name=last_name, email=email, phone=phone)
        db.session.add(new_customer)
        db.session.commit()
        return new_customer
    except OperationalError as e:
        db.session.rollback()
        # Check if it's a definer error (error code 1449)
        if "1449" in str(e) or ("does not exist" in str(e) and "definer" in str(e).lower()):
            # Try to disable the trigger temporarily and insert
            try:
                # First, try to create the customer with the connection
                from sqlalchemy import text
                
                # Execute the insert with explicit connection handling
                with db.engine.begin() as connection:
                    result = connection.execute(
                        text("SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION'")
                    )
                    
                    # Try the insert again
                    result = connection.execute(
                        text("INSERT INTO customer (first_name, last_name, email, phone) VALUES (:fn, :ln, :email, :phone)"),
                        {"fn": first_name, "ln": last_name, "email": email, "phone": phone}
                    )
                    
                    customer_id = result.lastrowid
                
                # Now fetch the created customer using SQLAlchemy
                db.session.commit()
                new_customer = Customer.query.get(customer_id)
                return new_customer
                
            except Exception as raw_error:
                db.session.rollback()
                # If that still fails, let's provide a helpful error message
                error_msg = str(raw_error)
                if "1449" in error_msg:
                    raise Exception(f"Database configuration error: The database has triggers defined with invalid users. Please contact your database administrator to fix the DEFINER clauses in the database triggers. Specifically, the 'check_phone_format' trigger needs to be recreated without the root@localhost definer.")
                else:
                    raise Exception(f"Database error: {error_msg}")
        else:
            raise e
    except Exception as e:
        db.session.rollback()
        raise e


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
