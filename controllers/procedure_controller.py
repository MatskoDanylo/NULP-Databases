from flask import Blueprint, request, jsonify
import logging

from services.procedure_service import (
    call_copy_to_random_tables,
    call_calculate_dynamic_statistic,
    call_insert_batch_to_extra_table,
    call_insert_into_extra_table,
    call_link_artist_to_event
)

procedure_controller = Blueprint('procedure_controller', __name__)

# Configure logging
logging.basicConfig(level=logging.DEBUG)

@procedure_controller.route('/procedures/copy_to_random_tables', methods=['POST'])
def copy_to_random_tables():
    source_table = request.json.get('source_table')
    logging.debug(f"Received source_table: {source_table}")
    
    if not source_table:
        return jsonify({"error": "source_table is required"}), 400
    
    result = call_copy_to_random_tables(source_table)
    logging.debug(f"Result from call_copy_to_random_tables: {result}")
    
    if isinstance(result, tuple):
        return jsonify(result[0]), result[1]
    return jsonify(result), 200


# Route to call CalculateDynamicStatistic
@procedure_controller.route('/procedures/calculate_dynamic_statistic', methods=['POST'])
def calculate_dynamic_statistic():
    table_name = request.json.get('table_name')
    column_name = request.json.get('column_name')
    stat_type = request.json.get('stat_type')
    result = call_calculate_dynamic_statistic(table_name, column_name, stat_type)
    if isinstance(result, tuple):
        return jsonify(result[0]), result[1]
    return jsonify(result), 200


# Route to call InsertBatchToExtraTable
@procedure_controller.route('/procedures/insert_batch_to_extra_table', methods=['POST'])
def insert_batch_to_extra_table():
    result = call_insert_batch_to_extra_table()
    if isinstance(result, tuple):
        return jsonify(result[0]), result[1]
    return jsonify(result), 200

# Route to call InsertIntoExtraTable
@procedure_controller.route('/procedures/insert_into_extra_table', methods=['POST'])
def insert_into_extra_table():
    column_value = request.json.get('column_value')
    extra_value = request.json.get('extra_value')
    result = call_insert_into_extra_table(column_value, extra_value)
    if isinstance(result, tuple):
        return jsonify(result[0]), result[1]
    return jsonify(result), 200


# Route to call LinkArtistToEvent
@procedure_controller.route('/procedures/link_artist_to_event', methods=['POST'])
def link_artist_to_event():
    artist_id = request.json.get('artist_id')
    event_id = request.json.get('event_id')
    result = call_link_artist_to_event(artist_id, event_id)

    # If result is a tuple with a status code (like {"error": ...}, 400), handle it properly
    if isinstance(result, tuple):
        return jsonify(result[0]), result[1]
    return jsonify(result), 200
