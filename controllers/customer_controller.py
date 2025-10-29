from flask import Blueprint, request, jsonify
from flasgger import swag_from

from services import customer_service

customer_bp = Blueprint('customer_bp', __name__)


@customer_bp.route('/customers', methods=['GET'])
@swag_from('../swagger_docs/customers/get_all_customers.yml')
def get_customers():
    customers = customer_service.get_all_customers()
    return jsonify([customer.to_dict() for customer in customers])


@customer_bp.route('/customers/<int:customer_id>', methods=['GET'])
@swag_from('../swagger_docs/customers/get_customer_by_id.yml')
def get_customer(customer_id):
    customer = customer_service.get_customer_by_id(customer_id)
    if customer is not None:  
        return jsonify(customer.to_dict())
    return {'message': 'Customer not found'}, 404  


@customer_bp.route('/customers', methods=['POST'])
@swag_from('../swagger_docs/customers/create_customer.yml')
def create_customer():
    try:
        data = request.get_json()
        if not data or not all(key in data for key in ['first_name', 'last_name', 'email', 'phone']):
            return {'error': 'Missing required fields: first_name, last_name, email, phone'}, 400
        
        customer = customer_service.create_customer(data['first_name'], data['last_name'], data['email'], data['phone'])
        return jsonify(customer.to_dict()), 201
    except Exception as e:
        return {'error': f'Database error: {str(e)}'}, 500


@customer_bp.route('/customers/<int:customer_id>', methods=['PUT'])
@swag_from('../swagger_docs/customers/update_customer.yml')
def update_customer(customer_id):
    data = request.get_json()
    customer = customer_service.update_customer(customer_id, data['first_name'], data['last_name'], data['email'],
                                                data['phone'])
    return jsonify(customer.to_dict())


@customer_bp.route('/customers/<int:customer_id>', methods=['DELETE'])
@swag_from('../swagger_docs/customers/delete_customer.yml')
def delete_customer(customer_id):
    customer_service.delete_customer(customer_id)
    return {'message': 'Customer deleted'}, 204
