from flask import Flask
from flask_login import LoginManager
from flask_migrate import Migrate
from flask_wtf import CSRFProtect
from models import db, User, Shop, Item, Category
from views import views_bp
import os
import secrets

# Import the function to register CLI commands
from cli_command import register_cli_commands

# Initialize Flask App
app = Flask(__name__)
migrate = Migrate(app, db)
csrf = CSRFProtect(app)

# Configuration
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY') or secrets.token_hex(32)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///Web_app.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['UPLOAD_FOLDER'] = 'static/artisans'

# Initialize Extensions
db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'views.login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Register Blueprints
app.register_blueprint(views_bp)

# --- Register CLI COMMANDS from cli_command module ---
register_cli_commands(app)

# --- MAIN EXECUTION ---
if __name__ == '__main__':
    app.run(debug=True)