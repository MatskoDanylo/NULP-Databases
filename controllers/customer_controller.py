from flask import Blueprint, request, jsonify

from services import customer_service

customer_bp = Blueprint('customer_bp', __name__)


# Виведення всіх клієнтів
@customer_bp.route('/customers', methods=['GET'])
def get_customers():
    customers = customer_service.get_all_customers()
    return jsonify([customer.to_dict() for customer in customers])


# Виведення одного клієнта за ID
@customer_bp.route('/customers/<int:customer_id>', methods=['GET'])
def get_customer(customer_id):
    customer = customer_service.get_customer_by_id(customer_id)
    if customer is not None:  # Перевірка на None
        return jsonify(customer.to_dict())
    return {'message': 'Customer not found'}, 404  # Повертаємо 404, якщо клієнта не знайдено


# Вставка нового клієнта
@customer_bp.route('/customers', methods=['POST'])
def create_customer():
    data = request.get_json()
    customer = customer_service.create_customer(data['first_name'], data['last_name'], data['email'], data['phone'])
    return jsonify(customer.to_dict()), 201


# Оновлення клієнта
@customer_bp.route('/customers/<int:customer_id>', methods=['PUT'])
def update_customer(customer_id):
    data = request.get_json()
    customer = customer_service.update_customer(customer_id, data['first_name'], data['last_name'], data['email'],
                                                data['phone'])
    return jsonify(customer.to_dict())


# Видалення клієнта
@customer_bp.route('/customers/<int:customer_id>', methods=['DELETE'])
def delete_customer(customer_id):
    customer_service.delete_customer(customer_id)
    return {'message': 'Customer deleted'}, 204
