from models import db, User, Shop, Item, Address, Category
from datetime import datetime
from werkzeug.security import generate_password_hash

# --- DATABASE UTILITY FUNCTIONS ---

def reset_db():
    """Drops and recreates all tables (use for schema changes)."""
    print(" Dropping all tables...")
    db.drop_all()
    print(" Tables dropped.")
    print(" Creating new tables...")
    db.create_all()
    print(" Tables created.")

def clear_data():
    """Clears data from all main tables (faster reset for new data)."""
    print(" Clearing existing data...")
    # Delete from dependent tables first (Items -> Shops/Addresses -> Users)
    Item.query.delete()
    Shop.query.delete()
    Address.query.delete()
    User.query.delete()
    Category.query.delete()
    db.session.commit()
    print(" Data cleared from all tables.")


# --- CATEGORY SEEDER ---

def seed_categories():
    categories = [
        {"name": "Home & Functional Ceramics", "code": "CERAMIC"},
        {"name": "Sustainable Textiles & Fiber Art", "code": "TEXTILE"},
        {"name": "Leather & Wood Goods", "code": "WOOD"},
        {"name": "Personal Accessories & Jewelry", "code": "JEWELRY"},
        {"name": "Fine Art & Stationery", "code": "ART"},
        {"name": "Aromatics & Wellness", "code": "WELLNESS"},
        {"name": "Heirloom & Custom Gifts", "code": "GIFT"},
    ]
    for c in categories:
        # Check if category exists before adding
        if not Category.query.filter_by(code=c["code"]).first():
            db.session.add(Category(name=c["name"], code=c["code"]))
    db.session.commit()
    print(" Categories seeded")


# --- FULL ARTISAN DATASET (20 Artisans & 100 Items) ---
artisans = [
    {
        "user": {"username": "ZiaMadePH", "first_name": "Zia", "last_name": "Gonzales", "gender": "Female", "birthdate": "1995-03-12", "contact_num": "09171234567", "is_admin": True, "password": "admin123", "bio": "Preserving the legacy of Pampanga in modern form.", "profile_img_url": "artisans/zia.jpg"},
        "address": {"street_address": "88 Duyan St.", "city": "San Fernando", "province": "Pampanga", "zip_code": "2000"},
        "shop": {"name": "The Zia Clay", "description": "We fuse age-old Kapampangan hand-building techniques with contemporary design."},
        "items": [
            {"name": "Lola's Legacy Coffee Mug", "description": "Hand-coiled mug using Kapampangan technique.", "price": 850.0, "stock": 10, "category_code": "CERAMIC", "img_url": "products/1.1.jpg"},
            {"name": "Pampanga Sunrise Pinch Bowl", "description": "Set of three small, earthy bowls.", "price": 1200.0, "stock": 5, "category_code": "CERAMIC", "img_url": "products/1.2.jpg"},
            {"name": "Heritage Coil-Built Vase", "description": "Tall, structural vase built by hand-coiling.", "price": 4500.0, "stock": 3, "category_code": "CERAMIC", "img_url": "products/1.3.jpg"},
            {"name": "The Zia Signature Dinner Plate", "description": "Large plate with subtle intentional irregularity.", "price": 1500.0, "stock": 8, "category_code": "CERAMIC", "img_url": "products/1.4.jpg"},
            {"name": "Earth's Embrace Incense Holder", "description": "Organic piece designed to hold burning incense.", "price": 650.0, "stock": 12, "category_code": "CERAMIC", "img_url": "products/1.5.jpg"}
        ]
    },
    {
        "user": {"username": "AltheaCreates", "first_name": "Althea", "last_name": "Ramos", "gender": "Female", "birthdate": "1992-08-21", "contact_num": "09172345678", "is_admin": True, "password": "admin123", "bio": "Knitting therapy into every stitch.", "profile_img_url": "artisans/althea.jpg"},
        "address": {"street_address": "12 Munting Lupa", "city": "Quezon City", "province": "Metro Manila", "zip_code": "1100"},
        "shop": {"name": "Althea's Knit & Knot", "description": "Mindful throws and accessories supporting mothers."},
        "items": [
            {"name": "Kapayapaan Weighted Throw", "description": "Densely knit throw for anxiety relief.", "price": 7800.0, "stock": 4, "category_code": "TEXTILE", "img_url": "products/2.1.jpg"},
            {"name": "Hinga Meditation Mat", "description": "Circular mat made from recycled cotton rope.", "price": 3200.0, "stock": 6, "category_code": "TEXTILE", "img_url": "products/2.2.jpg"},
            {"name": "Resilience Texture Pillow Cover", "description": "Decorative cover with cable-knit patterns.", "price": 1800.0, "stock": 15, "category_code": "TEXTILE", "img_url": "products/2.3.jpg"},
            {"name": "Therapy Yarn Keychain Set", "description": "Small woven keychains made from scraps.", "price": 750.0, "stock": 20, "category_code": "TEXTILE", "img_url": "products/2.4.jpg"},
            {"name": "Moms' Collaborative Shawl", "description": "Symbolizing community and shared purpose.", "price": 4500.0, "stock": 7, "category_code": "TEXTILE", "img_url": "products/2.5.jpg"}
        ]
    },
    {
        "user": {"username": "KaiGoods", "first_name": "Kai", "last_name": "Tan", "gender": "Male", "birthdate": "1990-11-05", "contact_num": "09173456789", "is_admin": True, "password": "admin123", "bio": "Sustainable elegance from salvaged history.", "profile_img_url": "artisans/kai.jpg"},
        "address": {"street_address": "Blk 5 Lot 14 Aklan Rd.", "city": "Cebu City", "province": "Cebu", "zip_code": "6000"},
        "shop": {"name": "Kai's Minimalist Wood", "description": "Minimalist designs solely from reclaimed Philippine hardwoods."},
        "items": [
            {"name": "The Architect's Desk Organizer", "description": "Minimalist reclaimed Narra wood organizer.", "price": 2900.0, "stock": 9, "category_code": "WOOD", "img_url": "products/3.1.jpg"},
            {"name": "Honest Scrap Coaster Set", "description": "Set of four from construction waste.", "price": 1100.0, "stock": 18, "category_code": "WOOD", "img_url": "products/3.2.jpg"},
            {"name": "Enduring Elegance Cutting Board", "description": "Solid block from reclaimed hardwood.", "price": 3500.0, "stock": 6, "category_code": "WOOD", "img_url": "products/3.3.jpg"},
            {"name": "Recycled Timber Catchall Tray", "description": "Low-profile tray for essentials.", "price": 2100.0, "stock": 11, "category_code": "WOOD", "img_url": "products/3.4.jpg"},
            {"name": "Zero-Waste Planter Stand", "description": "Elevates ceramic planters.", "price": 1600.0, "stock": 14, "category_code": "WOOD", "img_url": "products/3.5.jpg"}
        ]
    },
    {
        "user": {"username": "MaelysWeave", "first_name": "Maelys", "last_name": "Santos", "gender": "Female", "birthdate": "1998-04-19", "contact_num": "09174567890", "is_admin": True, "password": "admin123", "bio": "Where patience is the medium.", "profile_img_url": "artisans/maelys.jpg"},
        "address": {"street_address": "77 Makisig Ave.", "city": "Makati", "province": "Metro Manila", "zip_code": "1200"},
        "shop": {"name": "Maëlys Fabric & Thread", "description": "Specializing in intricate embroidery of local flora."},
        "items": [
            {"name": "100-Hour Waling-Waling Art", "description": "Museum-quality orchid embroidery.", "price": 9500.0, "stock": 2, "category_code": "TEXTILE", "img_url": "products/4.1.jpg"},
            {"name": "Patient Stitch Bird Brooch", "description": "Hand-stitched native Philippine bird.", "price": 1900.0, "stock": 10, "category_code": "TEXTILE", "img_url": "products/4.2.jpg"},
            {"name": "Fauna Tapestry Wall Hanging", "description": "Lush forest scene with thousands of stitches.", "price": 14000.0, "stock": 1, "category_code": "TEXTILE", "img_url": "products/4.3.jpg"},
            {"name": "The Devotional Bookmark", "description": "Precise floral embroidery on fabric.", "price": 650.0, "stock": 25, "category_code": "TEXTILE", "img_url": "products/4.4.jpg"},
            {"name": "Monochrome Insect Study", "description": "Black and white geometry of a local insect.", "price": 3800.0, "stock": 5, "category_code": "TEXTILE", "img_url": "products/4.5.jpg"}
        ]
    },
    {
        "user": {"username": "EthanLeather", "first_name": "Ethan", "last_name": "Lopez", "gender": "Male", "birthdate": "1993-01-25", "contact_num": "09175678901", "is_admin": True, "password": "admin123", "bio": "Heirlooms built to defy fast fashion.", "profile_img_url": "artisans/ethan.jpg"},
        "address": {"street_address": "22 Shoe Road", "city": "Marikina", "province": "Metro Manila", "zip_code": "1800"},
        "shop": {"name": "Ethan's Leather Works", "description": "Hand-stitched in Marikina using vegetable-tanned leather."},
        "items": [
            {"name": "Marikina Heirloom Bifold Wallet", "description": "Hand saddle-stitched, guaranteed for life.", "price": 3400.0, "stock": 12, "category_code": "WOOD", "img_url": "products/5.1.jpg"},
            {"name": "The Traveler's Sentinel Pouch", "description": "Compact zippered pouch for passports or tools.", "price": 4100.0, "stock": 8, "category_code": "WOOD", "img_url": "products/5.2.jpg"},
            {"name": "Legacy Full-Grain Belt", "description": "Durable leather belt with solid brass buckle.", "price": 3800.0, "stock": 10, "category_code": "WOOD", "img_url": "products/5.3.jpg"},
            {"name": "Desk Mat of Durability", "description": "Large, thick leather mat for the desktop.", "price": 6200.0, "stock": 5, "category_code": "WOOD", "img_url": "products/5.4.jpg"},
            {"name": "Personalized Cable Keeper Set", "description": "Three leather snaps to manage wires.", "price": 1050.0, "stock": 20, "category_code": "WOOD", "img_url": "products/5.5.jpg"}
        ]
    },
    {
        "user": {"username": "ZoeyAtbp", "first_name": "Zoey", "last_name": "Villanueva", "gender": "Female", "birthdate": "2001-07-30", "contact_num": "09176789012", "is_admin": True, "password": "admin123", "bio": "Immortality for nature's most delicate moments.", "profile_img_url": "artisans/zoey.jpg"},
        "address": {"street_address": "9 Palawan Way", "city": "Puerto Princesa", "province": "Palawan", "zip_code": "5300"},
        "shop": {"name": "Zoey's Resin Gems", "description": "Preserving elements of the Philippine wilderness in resin."},
        "items": [
            {"name": "Immortality Petal Pendant", "description": "Vibrant orchid petal in a clear resin necklace.", "price": 2200.0, "stock": 15, "category_code": "JEWELRY", "img_url": "products/6.1.jpg"},
            {"name": "Palawan Sand Micro-Landscape Ring", "description": "Layers of sand and moss in a resin dome.", "price": 1950.0, "stock": 10, "category_code": "JEWELRY", "img_url": "products/6.2.jpg"},
            {"name": "Ephemeral Beauty Stud Earrings", "description": "Preserved moss and gold leaf studs.", "price": 1400.0, "stock": 25, "category_code": "JEWELRY", "img_url": "products/6.3.jpg"},
            {"name": "Botanical Micro-Museum Coasters", "description": "Clear resin coasters with dried ferns.", "price": 3800.0, "stock": 6, "category_code": "JEWELRY", "img_url": "products/6.4.jpg"},
            {"name": "Oceanic Flow Hair Pin", "description": "Blue resin hair pin with seafoam elements.", "price": 1650.0, "stock": 10, "category_code": "JEWELRY", "img_url": "products/6.5.jpg"}
        ]
    },
    {
        "user": {"username": "LiamPrint", "first_name": "Liam", "last_name": "De La Cruz", "gender": "Male", "birthdate": "1996-10-01", "contact_num": "09177890123", "is_admin": True, "password": "admin123", "bio": "Reviving the luxurious, tactile art of communication.", "profile_img_url": "artisans/liam.jpg"},
        "address": {"street_address": "4 Antique Press Lane", "city": "Manila", "province": "Metro Manila", "zip_code": "1008"},
        "shop": {"name": "Liam Letterpress Studio", "description": "Using antique presses for soulful stationery."},
        "items": [
            {"name": "The Tactile Thank You Card Set", "description": "Set of 10 on thick cotton paper.", "price": 1800.0, "stock": 30, "category_code": "ART", "img_url": "products/7.1.jpg"},
            {"name": "Slower is Soulful Art Print", "description": "Black and white quote print.", "price": 1500.0, "stock": 15, "category_code": "ART", "img_url": "products/7.2.jpg"},
            {"name": "Hand-Fed Custom Stationery", "description": "Personalized letterhead individually hand-fed.", "price": 4500.0, "stock": 5, "category_code": "ART", "img_url": "products/7.3.jpg"},
            {"name": "The Legacy Coaster Set", "description": "Thick-stock coasters with Filipino script.", "price": 1100.0, "stock": 20, "category_code": "ART", "img_url": "products/7.4.jpg"},
            {"name": "Vintage Manila Map Print", "description": "Two-color letterpress on archival paper.", "price": 2800.0, "stock": 10, "category_code": "ART", "img_url": "products/7.5.jpg"}
        ]
    },
    {
        "user": {"username": "LunaCrafted", "first_name": "Luna", "last_name": "Reyes", "gender": "Female", "birthdate": "1997-12-14", "contact_num": "09178901234", "is_admin": True, "password": "admin123", "bio": "Jewelry as a personal celestial map.", "profile_img_url": "artisans/luna.jpg"},
        "address": {"street_address": "16 Constellation Blvd.", "city": "Legazpi", "province": "Albay", "zip_code": "4500"},
        "shop": {"name": "Luna & Stars Jewelry", "description": "Hand-set stones replication your birth constellation."},
        "items": [
            {"name": "Custom Birth Constellation Necklace", "description": "Pendant mirroring wearer's star pattern.", "price": 3900.0, "stock": 8, "category_code": "JEWELRY", "img_url": "products/8.1.jpg"},
            {"name": "Solstice Moon Phase Ring", "description": "Silver ring engraved with a significant moon phase.", "price": 3200.0, "stock": 10, "category_code": "JEWELRY", "img_url": "products/8.2.jpg"},
            {"name": "Celestial Map Studs", "description": "Geometric studs of Philippine sky stars.", "price": 2100.0, "stock": 18, "category_code": "JEWELRY", "img_url": "products/8.3.jpg"},
            {"name": "Andromeda Stacking Bracelet", "description": "Silver chain with celestial charms.", "price": 2500.0, "stock": 15, "category_code": "JEWELRY", "img_url": "products/8.4.jpg"},
            {"name": "Cosmic Connection Locket", "description": "High-polish locket engraved with zodiac sign.", "price": 4800.0, "stock": 7, "category_code": "JEWELRY", "img_url": "products/8.5.jpg"}
        ]
    },
    {
        "user": {"username": "CieloScents", "first_name": "Cielo", "last_name": "Mendoza", "gender": "Female", "birthdate": "1991-05-08", "contact_num": "09179012345", "is_admin": True, "password": "admin123", "bio": "The authentic scent of the Philippines, bottled.", "profile_img_url": "artisans/cielo.jpg"},
        "address": {"street_address": "33 Aromatics Circle", "city": "Naga City", "province": "Camarines Sur", "zip_code": "4400"},
        "shop": {"name": "Cielo Aromatic Crafts", "description": "Natural waxes and local oils capturing Sampaguita and sea air."},
        "items": [
            {"name": "Sampaguita Dawn Soy Candle", "description": "Soy wax with pure essential oil blend.", "price": 1400.0, "stock": 20, "category_code": "WELLNESS", "img_url": "products/9.1.jpg"},
            {"name": "Bicol Sea Salt Air Reed Diffuser", "description": "Non-toxic diffuser with local oils.", "price": 1800.0, "stock": 15, "category_code": "WELLNESS", "img_url": "products/9.2.jpg"},
            {"name": "Post-Rain Earth Musk Wax Melts", "description": "Evokes the smell of petrichor.", "price": 850.0, "stock": 30, "category_code": "WELLNESS", "img_url": "products/9.3.jpg"},
            {"name": "Gumamela & Honey Hand Balm", "description": "Rich balm with local beeswax.", "price": 950.0, "stock": 25, "category_code": "WELLNESS", "img_url": "products/9.4.jpg"},
            {"name": "Aromatherapy Travel Tin Set", "description": "Set of three portable candles.", "price": 2500.0, "stock": 10, "category_code": "WELLNESS", "img_url": "products/9.5.jpg"}
        ]
    },
    {
        "user": {"username": "NicoCeramics", "first_name": "Nico", "last_name": "Lim", "gender": "Male", "birthdate": "1994-06-28", "contact_num": "09181234567", "is_admin": True, "password": "admin123", "bio": "Embracing Wabi-Sabi: The beauty of the human touch.", "profile_img_url": "artisans/nico.jpg"},
        "address": {"street_address": "1 Glaze Trail", "city": "Valenzuela", "province": "Metro Manila", "zip_code": "1440"},
        "shop": {"name": "Nico's Wheel & Glaze", "description": "Hand-thrown ceramics with unique glaze crackle."},
        "items": [
            {"name": "Wabi-Sabi Daily Coffee Mug", "description": "Hand-thrown with a unique crackle glaze.", "price": 950.0, "stock": 10, "category_code": "CERAMIC", "img_url": "products/10.1.jpg"},
            {"name": "Honest Form Serving Platter", "description": "Wide platter with asymmetrical shape.", "price": 3600.0, "stock": 5, "category_code": "CERAMIC", "img_url": "products/10.2.jpg"},
            {"name": "Proof of Hand Dinner Bowl Set", "description": "Two rustic, durable bowls.", "price": 1800.0, "stock": 8, "category_code": "CERAMIC", "img_url": "products/10.3.jpg"},
            {"name": "Artisan's Thumbprint Sake Cups", "description": "Four cups with thumb indentations.", "price": 1400.0, "stock": 12, "category_code": "CERAMIC", "img_url": "products/10.4.jpg"},
            {"name": "Glaze Study Decorative Tile", "description": "Collector's piece with experimental glaze.", "price": 1200.0, "stock": 6, "category_code": "CERAMIC", "img_url": "products/10.5.jpg"}
        ]
    },
    {
        "user": {"username": "SkyeTextile", "first_name": "Skye", "last_name": "Garcia", "gender": "Female", "birthdate": "1999-02-03", "contact_num": "09182345678", "is_admin": True, "password": "admin123", "bio": "Giving history a second life.", "profile_img_url": "artisans/skye.jpg"},
        "address": {"street_address": "5 Barong Thread", "city": "Baguio City", "province": "Benguet", "zip_code": "2600"},
        "shop": {"name": "Skye and Stitch", "description": "Deconstructing vintage Barongs into modern accessories."},
        "items": [
            {"name": "Reborn Barong Tagalog Clutch", "description": "Crafted from disassembled vintage Barongs.", "price": 2600.0, "stock": 10, "category_code": "TEXTILE", "img_url": "products/11.1.jpg"},
            {"name": "Filipiniana Scrap Patchwork Pouch", "description": "Mosaic of old Filipiniana dress scraps.", "price": 1500.0, "stock": 15, "category_code": "TEXTILE", "img_url": "products/11.2.jpg"},
            {"name": "The Second Life Upcycled Scarf", "description": "Pieced from discarded luxury silk.", "price": 3100.0, "stock": 7, "category_code": "TEXTILE", "img_url": "products/11.3.jpg"},
            {"name": "Textile History Wall Banner", "description": "Layered sections of Filipino textile remnants.", "price": 4200.0, "stock": 4, "category_code": "TEXTILE", "img_url": "products/11.4.jpg"},
            {"name": "Zero-Waste Cord Wraps", "description": "Set of small fabric wraps from scraps.", "price": 800.0, "stock": 30, "category_code": "TEXTILE", "img_url": "products/11.5.jpg"}
        ]
    },
    {
        "user": {"username": "AmariMetals", "first_name": "Amari", "last_name": "Dela Rosa", "gender": "Female", "birthdate": "1990-09-17", "contact_num": "09183456789", "is_admin": True, "password": "admin123", "bio": "Funding the survival of a national treasure.", "profile_img_url": "artisans/amari.jpg"},
        "address": {"street_address": "1 Filigree St.", "city": "Vigan", "province": "Ilocos Sur", "zip_code": "2700"},
        "shop": {"name": "Amari Fine Filigree", "description": "Centuries-old filigree techniques using twisted metal threads."},
        "items": [
            {"name": "Ancestral Filigree Drop Earrings", "description": "Sterling silver lacelike metalwork.", "price": 5500.0, "stock": 8, "category_code": "JEWELRY", "img_url": "products/12.1.jpg"},
            {"name": "Survival of the Craft Ring", "description": "Substantial ring symbolizing filigree dedication.", "price": 4800.0, "stock": 6, "category_code": "JEWELRY", "img_url": "products/12.2.jpg"},
            {"name": "Heirloom-Quality Filigree Brooch", "description": "Statement brooch from fine silver wire.", "price": 6200.0, "stock": 5, "category_code": "JEWELRY", "img_url": "products/12.3.jpg"},
            {"name": "The Ilocos Bloom Pendant", "description": "Floral pendant using traditional filigree techniques.", "price": 3500.0, "stock": 10, "category_code": "JEWELRY", "img_url": "products/12.4.jpg"},
            {"name": "Metal Thread Dainty Bracelet", "description": "Fine silver thread perfect for stacking.", "price": 2900.0, "stock": 15, "category_code": "JEWELRY", "img_url": "products/12.5.jpg"}
        ]
    },
    {
        "user": {"username": "ChloeQuilts", "first_name": "Chloe", "last_name": "Aquino", "gender": "Female", "birthdate": "1993-03-29", "contact_num": "09184567890", "is_admin": True, "password": "admin123", "bio": "Stitching family memories into lasting comfort.", "profile_img_url": "artisans/chloe.jpg"},
        "address": {"street_address": "18 Comfort Lane", "city": "Quezon City", "province": "Metro Manila", "zip_code": "1121"},
        "shop": {"name": "Chloe's Comfort Quilt", "description": "Heirlooms combining fabric scraps from shared history."},
        "items": [
            {"name": "The Generational Memory Quilt", "description": "Large custom quilt from clothing scraps.", "price": 18000.0, "stock": 1, "category_code": "GIFT", "img_url": "products/13.1.jpg"},
            {"name": "Heavy Comfort Lap Throw", "description": "Smaller quilt for security and embrace.", "price": 8500.0, "stock": 5, "category_code": "GIFT", "img_url": "products/13.2.jpg"},
            {"name": "Family History Stitched Pillow", "description": "Decorative pillow from patchwork blocks.", "price": 3500.0, "stock": 8, "category_code": "GIFT", "img_url": "products/13.3.jpg"},
            {"name": "The Endurance Baby Quilt", "description": "Durable cotton designed to be passed down.", "price": 4900.0, "stock": 6, "category_code": "GIFT", "img_url": "products/13.4.jpg"},
            {"name": "Patchwork Table Runner", "description": "Runner made from curated remnants.", "price": 2800.0, "stock": 10, "category_code": "GIFT", "img_url": "products/13.5.jpg"}
        ]
    },
    {
        "user": {"username": "JaviBuilds", "first_name": "Javi", "last_name": "Torres", "gender": "Male", "birthdate": "1997-07-07", "contact_num": "09185678901", "is_admin": True, "password": "admin123", "bio": "Heirloom quality built with necessary patience.", "profile_img_url": "artisans/javi.jpg"},
        "address": {"street_address": "6 Joinery Road", "city": "Davao City", "province": "Davao del Sur", "zip_code": "8000"},
        "shop": {"name": "Javi Custom Furniture", "description": "Hand-sanded and joined resilient furniture."},
        "items": [
            {"name": "The Patient-Crafted Console Table", "description": "Hardwood entry table with hand-oiled finish.", "price": 16000.0, "stock": 2, "category_code": "WOOD", "img_url": "products/14.1.jpg"},
            {"name": "Legacy Wood Hand-Sanded Stool", "description": "Sturdy compact stool built to last a century.", "price": 7500.0, "stock": 5, "category_code": "WOOD", "img_url": "products/14.2.jpg"},
            {"name": "Anti-Disposable Investment Shelf", "description": "Minimalist shelf with traditional joinery.", "price": 9800.0, "stock": 3, "category_code": "WOOD", "img_url": "products/14.3.jpg"},
            {"name": "The Heirloom Cutting Board", "description": "Extra-thick heavy-duty board.", "price": 4500.0, "stock": 7, "category_code": "WOOD", "img_url": "products/14.4.jpg"},
            {"name": "Woodworker's Signature Pen Holder", "description": "Flawless finish on Philippine mahogany.", "price": 2100.0, "stock": 10, "category_code": "WOOD", "img_url": "products/14.5.jpg"}
        ]
    },
    {
        "user": {"username": "AvaPaints", "first_name": "Ava", "last_name": "Salazar", "gender": "Female", "birthdate": "2000-04-11", "contact_num": "09186789012", "is_admin": True, "password": "admin123", "bio": "Finding art in the unexpected, natural canvas.", "profile_img_url": "artisans/ava.jpg"},
        "address": {"street_address": "15 River Stone Path", "city": "Tagaytay City", "province": "Cavite", "zip_code": "4120"},
        "shop": {"name": "Ava’s Painted Stones", "description": "Detailed miniature landscapes on smooth river stones."},
        "items": [
            {"name": "River Stone Miniature Landscape", "description": "Detailed rice terrace or beach scene.", "price": 1500.0, "stock": 15, "category_code": "ART", "img_url": "products/15.1.jpg"},
            {"name": "Found Beauty Rock", "description": "Lifelike painting of a Philippine Eagle.", "price": 1800.0, "stock": 10, "category_code": "ART", "img_url": "products/15.2.jpg"},
            {"name": "Custom Pet Portrait Stone", "description": "Detailed miniature on a natural stone.", "price": 2500.0, "stock": 5, "category_code": "ART", "img_url": "products/15.3.jpg"},
            {"name": "Flora Garden Markers", "description": "Set of three flat stones with herbs.", "price": 1900.0, "stock": 12, "category_code": "ART", "img_url": "products/15.4.jpg"},
            {"name": "Painted Pebble Paperweight", "description": "Elegant painted stone for workspaces.", "price": 1100.0, "stock": 18, "category_code": "ART", "img_url": "products/15.5.jpg"}
        ]
    },
    {
        "user": {"username": "XanderWares", "first_name": "Xander", "last_name": "Bautista", "gender": "Male", "birthdate": "1995-08-04", "contact_num": "09187890123", "is_admin": True, "password": "admin123", "bio": "Translating rhythm and feeling into geometric form.", "profile_img_url": "artisans/xander.jpg"},
        "address": {"street_address": "22 Knotting Loop", "city": "Bacolod City", "province": "Negros Occidental", "zip_code": "6100"},
        "shop": {"name": "Xander's Modern Macrame", "description": "Complex patterns appealing to all senses."},
        "items": [
            {"name": "Rhythmic Form Wall Hanging", "description": "Geometric macrame wall art.", "price": 6800.0, "stock": 5, "category_code": "TEXTILE", "img_url": "products/16.1.jpg"},
            {"name": "Geometry of Emotion Planter", "description": "Sturdy macrame plant hanger.", "price": 2900.0, "stock": 10, "category_code": "TEXTILE", "img_url": "products/16.2.jpg"},
            {"name": "Quiet Strength Room Divider", "description": "Semi-transparent macrame panel.", "price": 12000.0, "stock": 2, "category_code": "TEXTILE", "img_url": "products/16.3.jpg"},
            {"name": "Sensory Texture Trivet Set", "description": "Three thick knotted trivets.", "price": 1500.0, "stock": 15, "category_code": "TEXTILE", "img_url": "products/16.4.jpg"},
            {"name": "Minimalist Knot Keychain", "description": "Demonstrating a complex knot pattern.", "price": 750.0, "stock": 20, "category_code": "TEXTILE", "img_url": "products/16.5.jpg"}
        ]
    },
    {
        "user": {"username": "FreyaClay", "first_name": "Freya", "last_name": "Castro", "gender": "Female", "birthdate": "1991-05-22", "contact_num": "09188901234", "is_admin": True, "password": "admin123", "bio": "Honest forms, perfectly imperfect.", "profile_img_url": "artisans/freya.jpg"},
        "address": {"street_address": "7 Earthy Hill", "city": "Iloilo City", "province": "Iloilo", "zip_code": "5000"},
        "shop": {"name": "Freya's Earthy Trinkets", "description": "Natural clay bearing fingertip marks."},
        "items": [
            {"name": "Perfectly Imperfect Jewelry Dish", "description": "Dish with clear fingertip marks.", "price": 750.0, "stock": 15, "category_code": "CERAMIC", "img_url": "products/17.1.jpg"},
            {"name": "Hand-Shaped Soap Tray", "description": "Intentionally irregular natural clay tray.", "price": 650.0, "stock": 20, "category_code": "CERAMIC", "img_url": "products/17.2.jpg"},
            {"name": "The Authentic Bowl", "description": "Decorative bowl with a heavy base.", "price": 1800.0, "stock": 10, "category_code": "CERAMIC", "img_url": "products/17.3.jpg"},
            {"name": "Organic Clay Planter", "description": "Porous planter mimicking earth texture.", "price": 900.0, "stock": 15, "category_code": "CERAMIC", "img_url": "products/17.4.jpg"},
            {"name": "Earthy Texture Candle Vessel", "description": "Simple unglazed clay vessel.", "price": 1100.0, "stock": 12, "category_code": "CERAMIC", "img_url": "products/17.5.jpg"}
        ]
    },
    {
        "user": {"username": "ZenCraftsMNL", "first_name": "Zen", "last_name": "Ramos", "gender": "Male", "birthdate": "1998-09-10", "contact_num": "09189012345", "is_admin": True, "password": "admin123", "bio": "Focused patience meets extraordinary detail.", "profile_img_url": "artisans/zen.jpg"},
        "address": {"street_address": "99 Folding Point", "city": "Pasig", "province": "Metro Manila", "zip_code": "1600"},
        "shop": {"name": "Zen Paper Art", "description": "3D art created by folding thousands of paper strips."},
        "items": [
            {"name": "Mindfulness Folded Wall Panel", "description": "Geometric art from thousands of modules.", "price": 7500.0, "stock": 3, "category_code": "ART", "img_url": "products/18.1.jpg"},
            {"name": "Focused Patience Quilled Piece", "description": "Rolled paper strips requiring intense concentration.", "price": 2900.0, "stock": 6, "category_code": "ART", "img_url": "products/18.2.jpg"},
            {"name": "Extraordinary Detail Frame", "description": "Decorated with hand-rolled paper flowers.", "price": 2200.0, "stock": 8, "category_code": "ART", "img_url": "products/18.3.jpg"},
            {"name": "The Calming Grid Art Print", "description": "Print of a complex paper grid.", "price": 1500.0, "stock": 15, "category_code": "ART", "img_url": "products/18.4.jpg"},
            {"name": "Geometric Paper Sculpture", "description": "Interlocking modules as desk ornament.", "price": 1800.0, "stock": 10, "category_code": "ART", "img_url": "products/18.5.jpg"}
        ]
    },
    {
        "user": {"username": "ElioLighting", "first_name": "Elio", "last_name": "Fernandez", "gender": "Male", "birthdate": "1994-12-03", "contact_num": "09191234567", "is_admin": True, "password": "admin123", "bio": "Illuminating your personal history.", "profile_img_url": "artisans/elio.jpg"},
        "address": {"street_address": "3 Resin Light", "city": "Cebu City", "province": "Cebu", "zip_code": "6004"},
        "shop": {"name": "Elio's Light & Resin", "description": "Bespoke lamps embedding mementos in clear resin."},
        "items": [
            {"name": "Illuminated Memory Lamp", "description": "Sentimental objects lit from within.", "price": 15000.0, "stock": 1, "category_code": "GIFT", "img_url": "products/19.1.jpg"},
            {"name": "History Cube Nightlight", "description": "Personalized nightlight embedding objects.", "price": 5800.0, "stock": 5, "category_code": "GIFT", "img_url": "products/19.2.jpg"},
            {"name": "Personal Talisman Desk Light", "description": "Table lamp with symbolic plants.", "price": 7500.0, "stock": 4, "category_code": "GIFT", "img_url": "products/19.3.jpg"},
            {"name": "Keepsake Resin Pendant", "description": "Dried flowers sealed in resin.", "price": 3200.0, "stock": 10, "category_code": "GIFT", "img_url": "products/19.4.jpg"},
            {"name": "Glow Coaster Set", "description": "Resin coasters with mementos.", "price": 4100.0, "stock": 6, "category_code": "GIFT", "img_url": "products/19.5.jpg"}
        ]
    },
    {
        "user": {"username": "MilaKape", "first_name": "Mila", "last_name": "Corpuz", "gender": "Female", "birthdate": "1992-06-16", "contact_num": "09192345678", "is_admin": True, "password": "admin123", "bio": "Mother's love and purity in every bar.", "profile_img_url": "artisans/mila.jpg"},
        "address": {"street_address": "1 Coconut Oil Dr.", "city": "Lucena City", "province": "Quezon", "zip_code": "4301"},
        "shop": {"name": "Mila Handmade Soaps", "description": "Natural cold-process soaps from pure local ingredients."},
        "items": [
            {"name": "Coconut Milk Bar", "description": "Unscented for sensitive skin.", "price": 350.0, "stock": 50, "category_code": "WELLNESS", "img_url": "products/20.1.jpg"},
            {"name": "Local Herb Soap Bar", "description": "Infused with local chamomile.", "price": 380.0, "stock": 40, "category_code": "WELLNESS", "img_url": "products/20.2.jpg"},
            {"name": "Calming Bath Soak", "description": "Natural salts and lavender oil.", "price": 750.0, "stock": 20, "category_code": "WELLNESS", "img_url": "products/20.3.jpg"},
            {"name": "Shea Butter Lip Balm", "description": "With local beeswax for moisture.", "price": 450.0, "stock": 30, "category_code": "WELLNESS", "img_url": "products/20.4.jpg"},
            {"name": "Tropical Citrus Kitchen Bar", "description": "Dense bar for removing kitchen odors.", "price": 400.0, "stock": 35, "category_code": "WELLNESS", "img_url": "products/20.5.jpg"}
        ]
    }
]


# --- CORE SEEDING LOGIC (Applied Fixes) ---
def seed_artisans():
    # Defensive check for category existence (Fix for IntegrityError)
    if not Category.query.first():
        print(" ERROR: when seeding artisans, no categories found. Please seed categories first. ok na")
        return

    for entry in artisans:
        u = entry["user"]
        
        # 1. Create User
        user = User(
            username=u["username"],
            first_name=u["first_name"],
            last_name=u["last_name"],
            gender=u["gender"],
            birthdate=datetime.strptime(u["birthdate"], "%Y-%m-%d"),
            contact_num=u["contact_num"],
            is_admin=u["is_admin"],
            bio=u.get("bio"),
            profile_img_url=u.get("profile_img_url"),
            password_hash=generate_password_hash(u["password"])
        )
        db.session.add(user)
        db.session.flush() # Flush to get user.user_id

        # 2. Create Address
        addr_data = entry["address"]
        address = Address(
            user_id=user.user_id,
            street_address=addr_data["street_address"],
            city=addr_data["city"],
            province=addr_data["province"],
            zip_code=addr_data["zip_code"]
        )
        db.session.add(address)

        # 3. Create Shop
        s_data = entry["shop"]
        shop = Shop(
            name=s_data["name"],
            description=s_data["description"],
            owner_id=user.user_id
        )
        db.session.add(shop)
        db.session.flush() # Flush to get shop.shop_id

        # FIX: Explicitly store the integer primary key to avoid OperationalError
        current_shop_id = shop.shop_id

        # 4. Create Items
        for item_data in entry["items"]:
            # Lookup category ID using the code
            cat = Category.query.filter_by(code=item_data["category_code"]).first()
            
            # FIX: Check if category was found (Prevents IntegrityError)
            if not cat:
                print(f" Warning: Category code '{item_data['category_code']}' not found for item '{item_data['name']}'. Skipping item.")
                continue

            item = Item(
                name=item_data["name"],
                description=item_data["description"],
                price=item_data["price"],
                stock=item_data["stock"],
                img_url=item_data["img_url"],
                category_id=cat.id, 
                shop_id=current_shop_id # Using the explicit integer ID
            )
            db.session.add(item)

    db.session.commit()
    print(" All 20 artisans, shops, and 100 items seeded successfully.")