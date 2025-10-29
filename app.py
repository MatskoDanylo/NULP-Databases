from flask import Flask
from flask_cors import CORS
from flasgger import Swagger, swag_from

from config import Config
from controllers.customer_controller import customer_bp
from controllers.event_controller import event_bp
from controllers.order_controller import order_bp
from controllers.procedure_controller import procedure_controller
from extensions import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Enable CORS for all routes
    CORS(app)
    
    # Initialize database
    db.init_app(app)
    
    # Simple Swagger setup
    swagger = Swagger(app)
    
    # Health check endpoint with inline swagger
    @app.route('/health', methods=['GET'])
    @swag_from({
        'tags': ['Health'],
        'responses': {
            200: {
                'description': 'API is healthy',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'status': {'type': 'string', 'example': 'healthy'},
                        'message': {'type': 'string', 'example': 'API is running'}
                    }
                }
            }
        }
    })
    def health_check():
        return {'status': 'healthy', 'message': 'API is running'}, 200

    # Database connection test endpoint with inline swagger
    @app.route('/test-db', methods=['GET'])
    @swag_from({
        'tags': ['Health'],
        'responses': {
            200: {
                'description': 'Database connection is working',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'status': {'type': 'string', 'example': 'success'},
                        'message': {'type': 'string', 'example': 'Database connection successful'},
                        'customer_count': {'type': 'integer', 'example': 5}
                    }
                }
            },
            500: {
                'description': 'Database connection failed',
                'schema': {
                    'type': 'object',
                    'properties': {
                        'status': {'type': 'string', 'example': 'error'},
                        'message': {'type': 'string', 'example': 'Database connection failed'}
                    }
                }
            }
        }
    })
    def test_db_connection():
        try:
            from services.customer_service import get_all_customers
            customers = get_all_customers()
            return {
                'status': 'success', 
                'message': 'Database connection successful',
                'customer_count': len(customers)
            }, 200
        except Exception as e:
            return {
                'status': 'error',
                'message': f'Database connection failed: {str(e)}'
            }, 500

    # Register blueprints
    app.register_blueprint(customer_bp)
    app.register_blueprint(order_bp)
    app.register_blueprint(event_bp)
    app.register_blueprint(procedure_controller)
    
    return app

# Create app instance
app = create_app()

if __name__ == '__main__':
    app.run(debug=True)
