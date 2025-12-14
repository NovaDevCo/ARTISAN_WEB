# seed.py
from models import db, User, Shop, Item, Address, Category

def get_or_create_category(code: str, name: str = None):
    """Return existing category or create a new one safely."""
    category = Category.query.filter_by(code=code).first()
    if not category:
        category = Category(
            code=code,
            name=name or code  # fallback applied when display name is missing
        )
        db.session.add(category)
        db.session.commit()
    return category



def create_default_user():
    user = User.query.filter_by(username='@ziagonzales').first()
    if not user:
        new_user = User(
            username='@ziagonzales',
            first_name='Zian',
            last_name='Gonzales',
            contact_num='000-000-0000',
            bio='No bio yet.',
            profile_img_url='artisans/Zia Gonzales.jpg',
            is_admin=True
        )
        new_user.set_password('admin123')
        db.session.add(new_user)
        db.session.commit()

        address = Address(
            user_id=new_user.user_id,
            street_address='232 Mykanto St.',
            city='Biringan City',
            province='East Province',
            zip_code='00000'
        )
        db.session.add(address)
        db.session.commit()
        print("✅ Default User and Address Created.")
    else:
        print("ℹ️ Default User already exists.")


def create_default_shop():
    user = User.query.filter_by(username='@ziagonzales').first()
    if user:
        shop = Shop.query.filter_by(owner_id=user.user_id).first()
        if not shop:
            new_shop = Shop(
                name='Zian Clay',
                description='This is Zia official shop.',
                owner_id=user.user_id
            )
            db.session.add(new_shop)
            db.session.commit()
            print("✅ Default Shop Created.")
        else:
            print("ℹ️ Default Shop already exists.")


def seed_shop_items():
    user = User.query.filter_by(username='@ziagonzales').first()
    if not user or not user.shops:
        print("⚠️ No default user/shop found. Run create_default_user() and create_default_shop() first.")
        return

    my_shop = user.shops[0]

    # Categories (safe get_or_create)
    woven = get_or_create_category("Woven", "Textiles & Woven")
    ceramics = get_or_create_category("Ceramics", "Ceramics & Pottery")

    # idagdag lang kung wala pa
    def add_if_missing(name, **kwargs):
        existing = Item.query.filter_by(name=name, shop_id=my_shop.shop_id).first()
        if not existing:
            item = Item(name=name, shop_id=my_shop.shop_id, **kwargs)
            db.session.add(item)

    add_if_missing(
        "Handmade Wooden Bowl",
        price=350.00,
        description="Crafted from local mahogany.",
        stock=10,
        category=woven,
        img_url="products/1.1.jpg"
    )

    add_if_missing(
        "Woven Artisan Bag",
        price=1200.00,
        description="Eco-friendly handwoven bag.",
        stock=5,
        category=woven,
        img_url="products/1.2.jpg"
    )

    add_if_missing(
        "Ceramic Coffee Mug",
        price=250.00,
        description="Hand-painted ceramic mug.",
        stock=20,
        category=ceramics,
        img_url="products/1.3.jpg"
    )

    db.session.commit()
    print("✅ Default Items Seeded for Zian's shop.")
