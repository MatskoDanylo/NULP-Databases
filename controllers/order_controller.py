from flask import Blueprint, request, jsonify

from services import order_service

order_bp = Blueprint('order_bp', __name__)


# Маршрут для отримання всіх замовлень або замовлень конкретного клієнта
@order_bp.route('/orders', methods=['GET'])
def get_orders():
    customer_id = request.args.get('customer_id')
    if customer_id:
        orders = order_service.get_orders_by_customer(customer_id)
    else:
        orders = order_service.get_all_orders()
    return jsonify([order.to_dict() for order in orders])


# Маршрут для отримання конкретного замовлення за order_id
@order_bp.route('/orders/<int:order_id>', methods=['GET'])
def get_order(order_id):
    order = order_service.get_order_by_id(order_id)
    if order:
        return jsonify(order.to_dict())
    return {'message': 'Order not found'}, 404


# Маршрут для створення нового замовлення
@order_bp.route('/orders', methods=['POST'])
def create_order():
    data = request.get_json()
    order = order_service.create_order(
        data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict()), 201


# Маршрут для оновлення існуючого замовлення
@order_bp.route('/orders/<int:order_id>', methods=['PUT'])
def update_order(order_id):
    data = request.get_json()
    order = order_service.update_order(
        order_id, data['customer_id'], data['order_date'], data['total_price'], data['payment_status']
    )
    return jsonify(order.to_dict())


# Маршрут для видалення замовлення
@order_bp.route('/orders/<int:order_id>', methods=['DELETE'])
def delete_order(order_id):
    order_service.delete_order(order_id)
    return {'message': 'Order deleted'}, 204
