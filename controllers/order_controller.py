from flask import Blueprint, request, jsonify
from flasgger import swag_from

from services import order_service

order_bp = Blueprint('order_bp', __name__)


@order_bp.route('/orders', methods=['GET'])
def get_orders():
    """
    Get all orders or orders by customer
    ---
    tags:
      - Orders
    parameters:
      - name: customer_id
        in: query
        type: integer
        required: false
        description: Filter orders by customer ID
    responses:
      200:
        description: List of orders
        schema:
          type: array
          items:
            type: object
            properties:
              order_id:
                type: integer
                example: 1
              customer_id:
                type: integer
                example: 1
              order_date:
                type: string
                format: date
                example: "2025-09-25"
              total_price:
                type: number
                format: float
                example: 99.99
              payment_status:
                type: string
                example: "paid"
    """
    customer_id = request.args.get('customer_id')
    if customer_id:
        orders = order_service.get_orders_by_customer(customer_id)
    else:
        orders = order_service.get_all_orders()
    return jsonify([order.to_dict() for order in orders])


@order_bp.route('/orders/<int:order_id>', methods=['GET'])
def get_order(order_id):
    """
    Get order by ID
    ---
    tags:
      - Orders
    parameters:
      - name: order_id
        in: path
        type: integer
        required: true
        description: Order ID
    responses:
      200:
        description: Order details
        schema:
          type: object
          properties:
            order_id:
              type: integer
              example: 1
            customer_id:
              type: integer
              example: 1
            order_date:
              type: string
              format: date
              example: "2025-09-25"
            total_price:
              type: number
              format: float
              example: 99.99
            payment_status:
              type: string
              example: "paid"
      404:
        description: Order not found
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Order not found"
    """
    order = order_service.get_order_by_id(order_id)
    if order:
        return jsonify(order.to_dict())
    return {'message': 'Order not found'}, 404


@order_bp.route('/orders', methods=['POST'])
def create_order():
    """
    Create a new order
    ---
    tags:
      - Orders
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            customer_id:
              type: integer
              example: 1
            order_date:
              type: string
              format: date
              example: "2025-09-25"
            total_price:
              type: number
              format: float
              example: 99.99
            payment_status:
              type: string
              example: "paid"
          required:
            - customer_id
            - order_date
            - total_price
            - payment_status
    responses:
      201:
        description: Order created successfully
        schema:
          type: object
          properties:
            order_id:
              type: integer
              example: 1
            customer_id:
              type: integer
              example: 1
            order_date:
              type: string
              format: date
              example: "2025-09-25"
            total_price:
              type: number
              format: float
              example: 99.99
            payment_status:
              type: string
              example: "paid"
    """
    data = request.get_json()
    order = order_service.create_order(
        data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict()), 201


@order_bp.route('/orders/<int:order_id>', methods=['PUT'])
def update_order(order_id):
    """
    Update order by ID
    ---
    tags:
      - Orders
    parameters:
      - name: order_id
        in: path
        type: integer
        required: true
        description: Order ID
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            customer_id:
              type: integer
              example: 1
            order_date:
              type: string
              format: date
              example: "2025-09-25"
            total_price:
              type: number
              format: float
              example: 99.99
            payment_status:
              type: string
              example: "paid"
          required:
            - customer_id
            - order_date
            - total_price
            - payment_status
    responses:
      200:
        description: Order updated successfully
        schema:
          type: object
          properties:
            order_id:
              type: integer
              example: 1
            customer_id:
              type: integer
              example: 1
            order_date:
              type: string
              format: date
              example: "2025-09-25"
            total_price:
              type: number
              format: float
              example: 99.99
            payment_status:
              type: string
              example: "paid"
    """
    data = request.get_json()
    order = order_service.update_order(
        order_id, data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict())


@order_bp.route('/orders/<int:order_id>', methods=['DELETE'])
def delete_order(order_id):
    """
    Delete order by ID
    ---
    tags:
      - Orders
    parameters:
      - name: order_id
        in: path
        type: integer
        required: true
        description: Order ID
    responses:
      204:
        description: Order deleted successfully
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Order deleted"
    """
    order_service.delete_order(order_id)
    return {'message': 'Order deleted'}, 204
