from sqlalchemy import text
from sqlalchemy.exc import IntegrityError, OperationalError

from extensions import db


def call_copy_to_random_tables(source_table):
    try:
        db.session.execute(
            text("CALL CopyToRandomTables(:source_table)"),
            {'source_table': source_table}
        )
        db.session.commit()
        return {"message": "Data copied to random tables successfully"}
    except IntegrityError:
        db.session.rollback()
        return {"error": "An integrity error occurred while copying data"}, 400
    except OperationalError as e:
        db.session.rollback()
        return {"error": str(e)}, 500


def call_calculate_dynamic_statistic(table_name, column_name, stat_type):
    try:
        db.session.execute(
            text("CALL CalculateDynamicStatistic(:table_name, :column_name, :stat_type, @statistic)"),
            {'table_name': table_name, 'column_name': column_name, 'stat_type': stat_type}
        )
        db.session.commit()

        # Retrieve the output parameter value
        statistic = db.session.execute(text("SELECT @statistic")).scalar()
        return {"statistic": statistic}
    except IntegrityError:
        db.session.rollback()
        return {"error": "An error occurred while calculating statistics"}, 400


def call_insert_batch_to_extra_table():
    try:
        db.session.execute(text("CALL InsertBatchToExtraTable()"))
        db.session.commit()
        return {"message": "Batch inserted successfully"}
    except IntegrityError:
        db.session.rollback()
        return {"error": "An error occurred while inserting batch data"}, 400


def call_insert_into_extra_table(column_value, extra_value):
    try:
        db.session.execute(
            text("CALL InsertIntoExtraTable(:column_value, :extra_value)"),
            {'column_value': column_value, 'extra_value': extra_value}
        )
        db.session.commit()
        return {"message": "Data inserted into extra table successfully"}
    except IntegrityError:
        db.session.rollback()
        return {"error": "An error occurred while inserting data"}, 400




def call_link_artist_to_event(artist_id, event_id):
    try:
        db.session.execute(
            text("CALL LinkArtistToEvent(:artist_id, :event_id)"),
            {'artist_id': artist_id, 'event_id': event_id}
        )
        db.session.commit()
        return {"message": "Artist linked to album successfully"}
    except IntegrityError:
        db.session.rollback()
        return {"error": "Artist is already linked to this album"}, 400
