from flask import Blueprint, request, jsonify
from flasgger import swag_from

from services import event_service

event_bp = Blueprint('event_bp', __name__)


@event_bp.route('/events', methods=['GET'])
def get_events():
    """
    Get all events
    ---
    tags:
      - Events
    responses:
      200:
        description: List of all events
        schema:
          type: array
          items:
            type: object
            properties:
              event_id:
                type: integer
                example: 1
              event_name:
                type: string
                example: "Summer Concert"
              event_date:
                type: string
                format: date
                example: "2025-07-15"
              event_time:
                type: string
                format: time
                example: "20:00:00"
              location:
                type: string
                example: "Central Park"
              event_type:
                type: string
                example: "Concert"
    """
    events = event_service.get_all_events()
    return jsonify([event.to_dict() for event in events])


@event_bp.route('/events/<int:event_id>/artists', methods=['GET'])
def get_event_artists(event_id):
    """
    Get artists for a specific event
    ---
    tags:
      - Events
    parameters:
      - name: event_id
        in: path
        type: integer
        required: true
        description: Event ID
    responses:
      200:
        description: List of artists for the event
        schema:
          type: array
          items:
            type: object
            properties:
              artist_id:
                type: integer
                example: 1
              artist_name:
                type: string
                example: "John Smith"
              genre:
                type: string
                example: "Rock"
              bio:
                type: string
                example: "Famous rock musician"
      404:
        description: No artists found for this event
        schema:
          type: object
          properties:
            message:
              type: string
              example: "No artists found for this event"
    """
    artists = event_service.get_artists_by_event(event_id) 
    if artists:
        return jsonify([artist.to_dict() for artist in artists])
    return {'message': 'No artists found for this event'}, 404


@event_bp.route('/events/<int:event_id>', methods=['GET'])
def get_event(event_id):
    """
    Get event by ID
    ---
    tags:
      - Events
    parameters:
      - name: event_id
        in: path
        type: integer
        required: true
        description: Event ID
    responses:
      200:
        description: Event details
        schema:
          type: object
          properties:
            event_id:
              type: integer
              example: 1
            event_name:
              type: string
              example: "Summer Concert"
            event_date:
              type: string
              format: date
              example: "2025-07-15"
            event_time:
              type: string
              format: time
              example: "20:00:00"
            location:
              type: string
              example: "Central Park"
            event_type:
              type: string
              example: "Concert"
      404:
        description: Event not found
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Event not found"
    """
    event = event_service.get_event_by_id(event_id)
    if event:
        return jsonify(event.to_dict())
    return {'message': 'Event not found'}, 404


@event_bp.route('/events', methods=['POST'])
def create_event():
    """
    Create a new event
    ---
    tags:
      - Events
    parameters:
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            event_name:
              type: string
              example: "Summer Concert"
            event_date:
              type: string
              format: date
              example: "2025-07-15"
            event_time:
              type: string
              format: time
              example: "20:00:00"
            location:
              type: string
              example: "Central Park"
            event_type:
              type: string
              example: "Concert"
          required:
            - event_name
            - event_date
            - event_time
            - location
            - event_type
    responses:
      201:
        description: Event created successfully
        schema:
          type: object
          properties:
            event_id:
              type: integer
              example: 1
            event_name:
              type: string
              example: "Summer Concert"
            event_date:
              type: string
              format: date
              example: "2025-07-15"
            event_time:
              type: string
              format: time
              example: "20:00:00"
            location:
              type: string
              example: "Central Park"
            event_type:
              type: string
              example: "Concert"
    """
    data = request.get_json()
    event = event_service.create_event(data['event_name'], data['event_date'], data['event_time'], data['location'],
                                       data['event_type'])
    return jsonify(event.to_dict()), 201


@event_bp.route('/events/<int:event_id>', methods=['PUT'])
def update_event(event_id):
    """
    Update event by ID
    ---
    tags:
      - Events
    parameters:
      - name: event_id
        in: path
        type: integer
        required: true
        description: Event ID
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            event_name:
              type: string
              example: "Summer Concert"
            event_date:
              type: string
              format: date
              example: "2025-07-15"
            event_time:
              type: string
              format: time
              example: "20:00:00"
            location:
              type: string
              example: "Central Park"
            event_type:
              type: string
              example: "Concert"
          required:
            - event_name
            - event_date
            - event_time
            - location
            - event_type
    responses:
      200:
        description: Event updated successfully
        schema:
          type: object
          properties:
            event_id:
              type: integer
              example: 1
            event_name:
              type: string
              example: "Summer Concert"
            event_date:
              type: string
              format: date
              example: "2025-07-15"
            event_time:
              type: string
              format: time
              example: "20:00:00"
            location:
              type: string
              example: "Central Park"
            event_type:
              type: string
              example: "Concert"
    """
    data = request.get_json()
    event = event_service.update_event(event_id, data['event_name'], data['event_date'], data['event_time'],
                                       data['location'], data['event_type'])
    return jsonify(event.to_dict())


@event_bp.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    """
    Delete event by ID
    ---
    tags:
      - Events
    parameters:
      - name: event_id
        in: path
        type: integer
        required: true
        description: Event ID
    responses:
      204:
        description: Event deleted successfully
        schema:
          type: object
          properties:
            message:
              type: string
              example: "Event deleted"
    """
    event_service.delete_event(event_id)
    return {'message': 'Event deleted'}, 204
