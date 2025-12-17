from flask import Flask, render_template
from flask_login import LoginManager
from flask_migrate import Migrate
from models import db, User
from views import views_bp
from cli_command import register_cli_commands
import os # <--- ADDED THIS IMPORT

# --- Initialize Flask App ---
app = Flask(__name__)

# --- Configuration ---
app.config['SECRET_KEY'] = 'your_secret_key'  # use env var in production

# --- MODIFIED THIS LINE ---
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'Web_app.db')
# --- END MODIFIED LINE ---

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['UPLOAD_FOLDER'] = 'static/artisans'

# --- Initialize Extensions ---
db.init_app(app)
migrate = Migrate(app, db)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'views.login'

# --- User Loader ---
@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# --- Register Blueprints & CLI Commands ---
app.register_blueprint(views_bp)
register_cli_commands(app)

# --- Routes ---
@app.route("/")
def home():
    return render_template("home.html")

# --- Main Execution ---
if __name__ == '__main__':
    app.run(debug=True)