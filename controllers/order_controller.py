from flask import Blueprint, request, jsonify
from flasgger import swag_from

from services import order_service

order_bp = Blueprint('order_bp', __name__)


@order_bp.route('/orders', methods=['GET'])
@swag_from('../swagger_docs/orders/get_all_orders.yml')
def get_orders():
    customer_id = request.args.get('customer_id')
    if customer_id:
        orders = order_service.get_orders_by_customer(customer_id)
    else:
        orders = order_service.get_all_orders()
    return jsonify([order.to_dict() for order in orders])


@order_bp.route('/orders/<int:order_id>', methods=['GET'])
@swag_from('../swagger_docs/orders/get_order_by_id.yml')
def get_order(order_id):
    order = order_service.get_order_by_id(order_id)
    if order:
        return jsonify(order.to_dict())
    return {'message': 'Order not found'}, 404


@order_bp.route('/orders', methods=['POST'])
@swag_from('../swagger_docs/orders/create_order.yml')
def create_order():
    data = request.get_json()
    order = order_service.create_order(
        data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict()), 201


@order_bp.route('/orders/<int:order_id>', methods=['PUT'])
@swag_from('../swagger_docs/orders/update_order.yml')
def update_order(order_id):
    data = request.get_json()
    order = order_service.update_order(
        order_id, data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict())


@order_bp.route('/orders/<int:order_id>', methods=['DELETE'])
@swag_from('../swagger_docs/orders/delete_order.yml')
def delete_order(order_id):
    order_service.delete_order(order_id)
    return {'message': 'Order deleted'}, 204
