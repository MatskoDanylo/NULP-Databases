from flask import Flask
from flask_cors import CORS
from flasgger import Swagger, swag_from

from config import Config
from controllers.customer_controller import customer_bp
from controllers.event_controller import event_bp
from controllers.order_controller import order_bp
from controllers.procedure_controller import procedure_controller
from extensions import db

app = Flask(__name__)
app.config.from_object(Config)

# Enable CORS for all routes
CORS(app)

# Swagger configuration
swagger_config = {
    "headers": [],
    "specs": [
        {
            "endpoint": 'apispec',
            "route": '/apispec.json',
            "rule_filter": lambda rule: True,
            "model_filter": lambda tag: True,
        }
    ],
    "static_url_path": "/flasgger_static",
    "swagger_ui": True,
    "specs_route": "/swagger/"
}

swagger_template = {
    "swagger": "2.0",
    "info": {
        "title": "NULP Databases API",
        "description": "Event Management System API",
        "version": "1.0.0"
    },
    "host": "127.0.0.1:5000",
    "basePath": "/",
    "schemes": ["http"],
}

swagger = Swagger(app, config=swagger_config, template=swagger_template)

# Health check endpoint
@app.route('/health', methods=['GET'])
@swag_from('swagger_docs/general/health_check.yml')
def health_check():
    return {'status': 'healthy', 'message': 'API is running'}, 200

# Database connection test endpoint
@app.route('/test-db', methods=['GET'])
@swag_from('swagger_docs/general/database_test.yml')
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

db.init_app(app)


app.register_blueprint(customer_bp)

app.register_blueprint(order_bp)
app.register_blueprint(event_bp)

app.register_blueprint(procedure_controller)

if __name__ == '__main__':
    app.run(debug=True)
