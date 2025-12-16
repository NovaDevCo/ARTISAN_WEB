import click
from flask.cli import with_appcontext
from flask import current_app
from models import db, User, Shop, Item, Category

# Import seeding methods
from seed import seed_artisans, seed_categories

def register_cli_commands(app):
    """Registers custom CLI commands with the Flask application instance."""

    @app.cli.command("reset-db")
    @with_appcontext
    def reset_db():
        """Drop all tables in the database."""
        db.drop_all()
        click.echo("All tables dropped.")

    @app.cli.command("create-db")
    @with_appcontext
    def create_db():
        """Create all tables in the database."""
        db.create_all()
        click.echo("All tables created.")

    @app.cli.command("seed")
    @with_appcontext
    def seed():
        seed_categories()
        seed_artisans()
        db.session.commit()
        click.echo("Database seeded with default user, shop, and items.")

    @app.cli.command("clear-seed")
    @with_appcontext
    def clear_data():
        """Clear seeded data from the database."""
        User.query.delete()
        Shop.query.delete()
        Item.query.delete()
        Category.query.delete()
        db.session.commit()
        click.echo("Data cleared.")


