from flask import Blueprint, request, jsonify

from services import event_service

event_bp = Blueprint('event_bp', __name__)


# Виведення всіх подій
@event_bp.route('/events', methods=['GET'])
def get_events():
    events = event_service.get_all_events()
    return jsonify([event.to_dict() for event in events])


@event_bp.route('/events/<int:event_id>/artists', methods=['GET'])
def get_event_artists(event_id):
    artists = event_service.get_artists_by_event(event_id)  # Виклик сервісу для отримання артистів
    if artists:
        return jsonify([artist.to_dict() for artist in artists])
    return {'message': 'No artists found for this event'}, 404


# Виведення однієї події за ID
@event_bp.route('/events/<int:event_id>', methods=['GET'])
def get_event(event_id):
    event = event_service.get_event_by_id(event_id)
    if event:
        return jsonify(event.to_dict())
    return {'message': 'Event not found'}, 404


# Вставка нової події
@event_bp.route('/events', methods=['POST'])
def create_event():
    data = request.get_json()
    event = event_service.create_event(data['event_name'], data['event_date'], data['event_time'], data['location'],
                                       data['event_type'])
    return jsonify(event.to_dict()), 201


# Оновлення події
@event_bp.route('/events/<int:event_id>', methods=['PUT'])
def update_event(event_id):
    data = request.get_json()
    event = event_service.update_event(event_id, data['event_name'], data['event_date'], data['event_time'],
                                       data['location'], data['event_type'])
    return jsonify(event.to_dict())


# Видалення події
@event_bp.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    event_service.delete_event(event_id)
    return {'message': 'Event deleted'}, 204
