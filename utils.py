import os, secrets
from flask import current_app
from werkzeug.utils import secure_filename
from models import db, Category

def save_picture(form_picture):
    """Rename uploaded image with a random hex to prevent filename collisions, then save it."""
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(current_app.root_path, 'static/images', picture_fn)
    form_picture.save(picture_path)
    return 'images/' + picture_fn

def save_profile_picture(form_picture):
    """Rename profile image and store it under static/artisans."""
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = secure_filename(random_hex + f_ext)
    upload_folder = os.path.join(current_app.root_path, 'static/images')
    os.makedirs(upload_folder, exist_ok=True)
    picture_path = os.path.join(upload_folder, picture_fn)
    form_picture.save(picture_path)
    return f'images/{picture_fn}'

def get_or_create_category(category_name):
    """Standardize the category name and create it if it does not exist."""
    clean_name = category_name.strip().title()
    category = Category.query.filter_by(name=clean_name).first()
    if not category:
        category = Category(name=clean_name)
        db.session.add(category)
        db.session.commit()
    return category




def save_file(file, folder="uploads"):
    if not file or not hasattr(file, "filename"):
        return None

    filename = secure_filename(file.filename)
    upload_folder = os.path.join(current_app.root_path, "static", folder)
    os.makedirs(upload_folder, exist_ok=True)

    filepath = os.path.join(upload_folder, filename)
    file.save(filepath)

    return f"{folder}/{filename}"

