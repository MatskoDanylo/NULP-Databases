from flask import Flask

from config import Config
from controllers.customer_controller import customer_bp
from controllers.event_controller import event_bp
from controllers.order_controller import order_bp
from controllers.procedure_controller import procedure_controller
from extensions import db

app = Flask(__name__)
app.config.from_object(Config)

# Ініціалізація об'єкта db
db.init_app(app)

# Реєстрація маршруту
app.register_blueprint(customer_bp)

app.register_blueprint(order_bp)
app.register_blueprint(event_bp)

app.register_blueprint(procedure_controller)

if __name__ == '__main__':
    app.run(debug=True)
