from flask import Blueprint, request, jsonify
from flasgger import swag_from

from services import customer_service

customer_bp = Blueprint('customer_bp', __name__)


@customer_bp.route('/customers', methods=['GET'])
@swag_from({
    'tags': ['Customers'],
    'responses': {
        200: {
            'description': 'List of all customers',
            'schema': {
                'type': 'array',
                'items': {
                    'type': 'object',
                    'properties': {
                        'customer_id': {'type': 'integer', 'example': 1},
                        'first_name': {'type': 'string', 'example': 'John'},
                        'last_name': {'type': 'string', 'example': 'Doe'},
                        'email': {'type': 'string', 'example': 'john.doe@email.com'},
                        'phone': {'type': 'string', 'example': '+1234567890'}
                    }
                }
            }
        }
    }
})
def get_customers():
    customers = customer_service.get_all_customers()
    return jsonify([customer.to_dict() for customer in customers])


@customer_bp.route('/customers/<int:customer_id>', methods=['GET'])
@swag_from({
    'tags': ['Customers'],
    'parameters': [
        {
            'name': 'customer_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the customer to retrieve'
        }
    ],
    'responses': {
        200: {
            'description': 'Customer details',
            'schema': {
                'type': 'object',
                'properties': {
                    'customer_id': {'type': 'integer', 'example': 1},
                    'first_name': {'type': 'string', 'example': 'John'},
                    'last_name': {'type': 'string', 'example': 'Doe'},
                    'email': {'type': 'string', 'example': 'john.doe@email.com'},
                    'phone': {'type': 'string', 'example': '+1234567890'}
                }
            }
        },
        404: {
            'description': 'Customer not found',
            'schema': {
                'type': 'object',
                'properties': {
                    'message': {'type': 'string', 'example': 'Customer not found'}
                }
            }
        }
    }
})
def get_customer(customer_id):
    customer = customer_service.get_customer_by_id(customer_id)
    if customer is not None:  
        return jsonify(customer.to_dict())
    return {'message': 'Customer not found'}, 404  


@customer_bp.route('/customers', methods=['POST'])
@swag_from({
    'tags': ['Customers'],
    'parameters': [
        {
            'name': 'body',
            'in': 'body',
            'required': True,
            'schema': {
                'type': 'object',
                'properties': {
                    'first_name': {'type': 'string', 'example': 'John'},
                    'last_name': {'type': 'string', 'example': 'Doe'},
                    'email': {'type': 'string', 'example': 'john.doe@email.com'},
                    'phone': {'type': 'string', 'example': '+1234567890'}
                },
                'required': ['first_name', 'last_name', 'email', 'phone']
            }
        }
    ],
    'responses': {
        201: {
            'description': 'Customer created successfully',
            'schema': {
                'type': 'object',
                'properties': {
                    'customer_id': {'type': 'integer', 'example': 1},
                    'first_name': {'type': 'string', 'example': 'John'},
                    'last_name': {'type': 'string', 'example': 'Doe'},
                    'email': {'type': 'string', 'example': 'john.doe@email.com'},
                    'phone': {'type': 'string', 'example': '+1234567890'}
                }
            }
        },
        400: {
            'description': 'Invalid input'
        }
    }
})
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
def update_customer(customer_id):
    """
    Update customer by ID
    ---
    tags:
      - Customers
    parameters:
      - name: customer_id
        in: path
        type: integer
        required: true
        description: Customer ID
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            first_name:
              type: string
              example: "John"
            last_name:
              type: string
              example: "Doe"
            email:
              type: string
              example: "john.doe@email.com"
            phone:
              type: string
              example: "+1234567890"
          required:
            - first_name
            - last_name
            - email
            - phone
    responses:
      200:
        description: Customer updated successfully
        schema:
          type: object
          properties:
            customer_id:
              type: integer
              example: 1
            first_name:
              type: string
              example: "John"
            last_name:
              type: string
              example: "Doe"
            email:
              type: string
              example: "john.doe@email.com"
            phone:
              type: string
              example: "+1234567890"
    """
    data = request.get_json()
    customer = customer_service.update_customer(customer_id, data['first_name'], data['last_name'], data['email'],
                                                data['phone'])
    return jsonify(customer.to_dict())


@customer_bp.route('/customers/<int:customer_id>', methods=['DELETE'])
def delete_customer(customer_id):
    """
    Delete customer by ID
    ---
    tags:
      - Customers
    parameters:
      - name: customer_id
        in: path
        type: integer
        required: true
        description: Customer ID
    responses:
      204:
        description: Customer deleted successfully
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Customer deleted"
    """
    customer_service.delete_customer(customer_id)
    return {'message': 'Customer deleted'}, 204
