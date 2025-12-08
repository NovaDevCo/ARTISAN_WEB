from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, TextAreaField, DecimalField, IntegerField, DateField, SelectField, SubmitField
from wtforms.validators import DataRequired, Length, EqualTo, NumberRange, Optional
from flask_wtf.file import FileField, FileAllowed

class RegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired(), Length(min=4, max=25)])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=6)])
    confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), EqualTo('password')])
    

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember_me = BooleanField('Remember Me')

class UserProfileForm(FlaskForm):
    first_name = StringField('First Name', validators=[Optional(), Length(max=150)])
    last_name = StringField('Last Name', validators=[Optional(), Length(max=150)])
    gender = StringField('Gender', validators=[Optional(), Length(10)])
    birthdate = DateField('Birthdate', format='%Y-%m-%d', validators=[Optional()])
    
    street_address = StringField('Street Address', validators=[Optional(), Length(max=150)])
    city = StringField('City', validators=[Optional(), Length(max=100)])
    province = StringField('Province', validators=[Optional(), Length(max=100)])
    zip_code = StringField('Zip Code', validators=[Optional(), Length(max=20)])
    contact_num = StringField('Contact Number', validators=[Optional(), Length(max=20)])
    
    # Use FileField for uploads, not StringField
    profile_image = FileField('Profile Image', validators=[Optional(),
        FileAllowed(['jpg', 'png', 'jpeg', 'gif'], 'Images only please!')
    ])
    bio = TextAreaField('Bio', validators=[Length(max=500)])

class ShopForm(FlaskForm):
    shop_name = StringField('Shop Name', validators=[DataRequired(), Length(max=150)])
    shop_description = TextAreaField('Description', validators=[Length(max=500)])
    # Logic for sub_location usually handled in backend, but field exists if needed
    sub_location_name = StringField('Branch Location Name', validators=[Length(max=150)])

class ItemForm(FlaskForm):
    name = StringField("Name", validators=[DataRequired()])
    description = StringField("Description", validators=[Optional()])
    price = DecimalField("Price", validators=[DataRequired()])
    stock = IntegerField("Stock", validators=[DataRequired()])
    image = FileField("Image", validators=[Optional()])

    # 🔑 Predefined categories
    category = SelectField(
        "Category",
        choices=[
            ("Textiles", "Textiles & Woven"),
            ("Clay", "Ceramics & Pottery"),
            ("Jewelry", "Jewelry & Accessories"),
            ("Woodcraft", "Woodcraft"),
            ("Leather", "Leather Goods"),
            ("Glass", "Glasswork"),
            ("Paper", "Paper & Stationery"),
            ("Natural", "Natural Materials"),
            ("HomeDecor", "Home Decor"),
            ("Fashion", "Fashion"),
            ("Kitchen", "Kitchen & Dining"),
            ("Wellness", "Wellness & Beauty"),
            ("Toys", "Toys & Games"),
            ("Spiritual", "Spiritual & Ritual"),
            ("Eco", "Eco-Friendly"),
            ("Heritage", "Cultural Heritage"),
            ("Minimalist", "Minimalist"),
            ("Bohemian", "Bohemian"),
            ("Rustic", "Rustic & Vintage"),
        ],
        validators=[DataRequired()]
    )

    

from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, DecimalField
from wtforms.validators import Optional

class SearchForm(FlaskForm):
    name = StringField(validators=[Optional()])

    category = SelectField(choices=[
        ("", "All Categories"),
        ("Textiles", "Textiles & Woven"),
        ("Clay", "Ceramics & Pottery"),
        ("Jewelry", "Jewelry & Accessories"),
        ("Woodcraft", "Woodcraft"),
        ("Leather", "Leather Goods"),
        ("Glass", "Glasswork"),
        ("Paper", "Paper & Stationery"),
        ("Natural", "Natural Materials"),
        ("HomeDecor", "Home Decor"),
        ("Fashion", "Fashion"),
        ("Kitchen", "Kitchen & Dining"),
        ("Wellness", "Wellness & Beauty"),
        ("Toys", "Toys & Games"),
        ("Spiritual", "Spiritual & Ritual"),
        ("Eco", "Eco-Friendly"),
        ("Heritage", "Cultural Heritage"),
        ("Minimalist", "Minimalist"),
        ("Bohemian", "Bohemian"),
        ("Rustic", "Rustic & Vintage"),
    ])

    min_price = DecimalField(validators=[Optional()])
    max_price = DecimalField(validators=[Optional()])
    sort_by = SelectField(choices=[
        ("price", "Price"),
        ("name", "Name"),
        ("stock", "Stock")
    ])
    order = SelectField(choices=[
        ("asc", "Ascending"),
        ("desc", "Descending")
    ])


class RatingForm(FlaskForm):
    value = SelectField(
        choices=[
            (1, "⭐"),
            (2, "⭐⭐"),
            (3, "⭐⭐⭐"),
            (4, "⭐⭐⭐⭐"),
            (5, "⭐⭐⭐⭐⭐")
        ],
        coerce=int,  # ensures data is an int, not str
        validators=[NumberRange(min=1, max=5)]
    )
    submit = SubmitField("Rate")

class AddToCartForm(FlaskForm):
    quantity = IntegerField(
        "Quantity",
        validators=[DataRequired(), NumberRange(min=1)],
        default=1
    )
    submit = SubmitField("Add to Cart")


class BlogPostForm(FlaskForm):
    title = StringField("Title", validators=[DataRequired()])
    description = TextAreaField("Description", validators=[DataRequired()])
    media = FileField("Upload Media", validators=[
    FileAllowed(['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'avi', 'webm'], 'Images and videos only!')
])

    submit = SubmitField("Publish")
