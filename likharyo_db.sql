CREATE DATABASE likharyo;

-- Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(150) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'images/default.png'
);

-- Addresses Table 
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A',
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000'
);

-- Shops Table
CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    owner_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_shop_id INT REFERENCES shops(shop_id) ON DELETE SET NULL
);

-- Categories Table
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300) UNIQUE NOT NULL,
    code VARCHAR(50)
);

-- Items Table
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price FLOAT NOT NULL,
    stock INT DEFAULT 0,
    img_url VARCHAR(250),
    category_id INT NOT NULL REFERENCES category(id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE
);

-- Cart Items Table
CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT DEFAULT 1
);

-- Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'placed',
    location VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order Items Table
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price FLOAT NOT NULL
);

-- Ratings Table
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    value INT NOT NULL,
    CONSTRAINT uq_user_shop_rating UNIQUE (user_id, shop_id)
);



-- 1. INSERT users 

INSERT INTO users (username, password_hash, first_name, last_name, gender, birthdate, contact_num, is_admin) VALUES
('ZiaMadePH', 'default_hash', 'Zia', 'Gonzales', 'Female', '1995-03-12', '09171234567', TRUE),
('AltheaCreates', 'default_hash', 'Althea', 'Ramos', 'Female', '1992-08-21', '09172345678', TRUE),
('KaiGoods', 'default_hash', 'Kai', 'Tan', 'Male', '1990-11-05', '09173456789', TRUE),
('MaelysWeave', 'default_hash', 'Maelys', 'Santos', 'Female', '1998-04-19', '09174567890', TRUE),
('EthanLeather', 'default_hash', 'Ethan', 'Lopez', 'Male', '1993-01-25', '09175678901', TRUE),
('ZoeyAtbp', 'default_hash', 'Zoey', 'Villanueva', 'Female', '2001-07-30', '09176789012', TRUE),
('LiamPrint', 'default_hash', 'Liam', 'De La Cruz', 'Male', '1996-10-01', '09177890123', TRUE),
('LunaCrafted', 'default_hash', 'Luna', 'Reyes', 'Female', '1997-12-14', '09178901234', TRUE),
('CieloScents', 'default_hash', 'Cielo', 'Mendoza', 'Female', '1991-05-08', '09179012345', TRUE),
('NicoCeramics', 'default_hash', 'Nico', 'Lim', 'Male', '1994-06-28', '09181234567', TRUE),
('SkyeTextile', 'default_hash', 'Skye', 'Garcia', 'Female', '1999-02-03', '09182345678', TRUE),
('AmariMetals', 'default_hash', 'Amari', 'Dela Rosa', 'Female', '1990-09-17', '09183456789', TRUE),
('ChloeQuilts', 'default_hash', 'Chloe', 'Aquino', 'Female', '1993-03-29', '09184567890', TRUE),
('JaviBuilds', 'default_hash', 'Javi', 'Torres', 'Male', '1997-07-07', '09185678901', TRUE),
('AvaPaints', 'default_hash', 'Ava', 'Salazar', 'Female', '2000-04-11', '09186789012', TRUE),
('XanderWares', 'default_hash', 'Xander', 'Bautista', 'Male', '1995-08-04', '09187890123', TRUE),
('FreyaClay', 'default_hash', 'Freya', 'Castro', 'Female', '1991-05-22', '09188901234', TRUE),
('ZenCraftsMNL', 'default_hash', 'Zen', 'Ramos', 'Male', '1998-09-10', '09189012345', TRUE),
('ElioLighting', 'default_hash', 'Elio', 'Fernandez', 'Male', '1994-12-03', '09191234567', TRUE),
('MilaKape', 'default_hash', 'Mila', 'Corpuz', 'Female', '1992-06-16', '09192345678', TRUE);

---2. ADDRESSES
INSERT INTO addresses (user_id, street_address, city, province, zip_code) VALUES
(1, '88 Duyan St.', 'San Fernando', 'Pampanga', '2000'),
(2, '12 Munting Lupa', 'Quezon City', 'Metro Manila', '1100'),
(3, 'Blk 5 Lot 14 Aklan Rd.', 'Cebu City', 'Cebu', '6000'),
(4, '77 Makisig Ave.', 'Makati', 'Metro Manila', '1200'),
(5, '22 Shoe Road', 'Marikina', 'Metro Manila', '1800'),
(6, '9 Palawan Way', 'Puerto Princesa', 'Palawan', '5300'),
(7, '4 Antique Press Lane', 'Manila', 'Metro Manila', '1008'),
(8, '16 Constellation Blvd.', 'Legazpi', 'Albay', '4500'),
(9, '33 Aromatics Circle', 'Naga City', 'Camarines Sur', '4400'),
(10, '1 Glaze Trail', 'Valenzuela', 'Metro Manila', '1440'),
(11, '5 Barong Thread', 'Baguio City', 'Benguet', '2600'),
(12, '1 Filigree St.', 'Vigan', 'Ilocos Sur', '2700'),
(13, '18 Comfort Lane', 'Quezon City', 'Metro Manila', '1121'),
(14, '6 Joinery Road', 'Davao City', 'Davao del Sur', '8000'),
(15, '15 River Stone Path', 'Tagaytay City', 'Cavite', '4120'),
(16, '22 Knotting Loop', 'Bacolod City', 'Negros Occidental', '6100'),
(17, '7 Earthy Hill', 'Iloilo City', 'Iloilo', '5000'),
(18, '99 Folding Point', 'Pasig', 'Metro Manila', '1600'),
(19, '3 Resin Light', 'Cebu City', 'Cebu', '6004'),
(20, '1 Coconut Oil Dr.', 'Lucena City', 'Quezon', '4301');


-- 3. INSERT category 
INSERT INTO category (name, code) VALUES
('Home & Functional Ceramics', 'CERAMIC'),
('Sustainable Textiles & Fiber Art', 'TEXTILE'),
('Leather & Wood Goods', 'WOOD'),
('Personal Accessories & Jewelry', 'JEWELRY'),
('Fine Art & Stationery', 'ART'),
('Aromatics & Wellness', 'WELLNESS'),
('Heirloom & Custom Gifts', 'GIFT');


-- 4. INSERT shops INSERT INTO shop
INSERT INTO shops (name, description, owner_id) VALUES
('The Zia Clay Studio', 'Preserving the legacy of Pampanga in modern form. We fuse age-old Kapampangan hand-building techniques with contemporary design. Every piece carries the intentional mark of human hands, ensuring that our heritage and the warmth of tradition enrich your modern home.', 1),
('Althea''s Knit & Knot', 'Knitting therapy into every stitch. Our throws and accessories are created with mindfulness, offering comfort and peace (Kapayapaan). Choosing our fiber art supports mothers who turn anxiety into beautiful, therapeutic, handcrafted textile works.', 2),
('Kai''s Minimalist Wood', 'Sustainable elegance from salvaged history. We refuse waste, creating minimalist designs solely from reclaimed Philippine hardwoods. Our commitment is to honesty, integrity, and building heirloom pieces that respect the material and last a lifetime.', 3),
('Maëlys Fabric & Thread', 'Where patience is the medium. We specialize in intricate embroidery, dedicating over a hundred hours to capturing the detail of local flora and fauna. Buy the passage of time—a tangible tribute to Filipino nature and slow, devotional craftsmanship.', 4),
('Ethan''s Leather Works', 'Heirlooms built to defy fast fashion. Hand-stitched in Marikina using only honest, vegetable-tanned leather. We offer a lifetime repair guarantee because we believe true quality is a promise of enduring companionship, not disposable trends.', 5),
('Zoey''s Resin Gems', 'Immortality for nature''s most delicate moments. I collect and preserve tiny elements of the Philippine wilderness—petals, moss, sand—in crystal-clear resin. Wear a micro-museum, a timeless piece of our islands’ fleeting beauty.', 6),
('Liam Letterpress Studio', 'Reviving the luxurious, tactile art of communication. We use antique presses to create stationery with a deep, physical impression. Choose the deliberate, soulful elegance of letterpress over the flatness of digital speed.', 7),
('Luna & Stars Jewelry', 'Jewelry as a personal celestial map. We hand-set precious stones to replicate your birth constellation or a significant moon phase. Our pieces are more than adornment; they are deeply personal talismans that track your unique cosmic history.', 8),
('Cielo Aromatic Crafts', 'The authentic scent of the Philippines, bottled. We reject synthetics, using natural waxes and local oils to capture the real aromas of Sampaguita, sea air, and earth. Light a true olfactory journey back to your favorite Filipino memory.', 9),
('Nico''s Wheel & Glaze', 'Embracing Wabi-Sabi: The beauty of the human touch. I hand-throw every ceramic piece, celebrating the slight wobble and unique glaze crackle that a machine would reject. Choose character and honest form over cold, factory perfection.', 10),
('Skye and Stitch', 'Giving history a second life. We meticulously deconstruct and reassemble damaged Barongs and vintage textiles into modern accessories. Our craft is a beautiful stand against textile waste and a celebration of rebirth.', 11),
('Amari Fine Filigree', 'Funding the survival of a national treasure. My jewelry uses centuries-old Filigree techniques, meticulously twisting metal threads by hand. You are investing in the survival of a beautiful, vanishing Filipino heritage craft.', 12),
('Chloe''s Comfort Quilt', 'Stitching family memories into lasting comfort. Our quilts are designed as heavy, comforting heirlooms, combining fabric scraps that represent shared history. We offer a generational embrace, built to gather memories for decades.', 13),
('Javi Custom Furniture', 'Heirloom quality built with necessary patience. I refuse to compromise on the time required for perfection. We hand-sand and join every piece to create resilient, soulful furniture—a quiet stand against disposable consumerism.', 14),
('Ava’s Painted Stones', 'Finding art in the unexpected, natural canvas. I use perfectly shaped river stones as my medium for detailed miniature landscapes. My work reminds you that profound beauty can be found anywhere, even in a simple rock underfoot.', 15),
('Xander''s Modern Macrame', 'Translating rhythm and feeling into geometric form. I specialize in complex macrame patterns, creating texture and structure that appeal to all the senses. Experience the quiet strength and sophistication of the knotted human hand.', 16),
('Freya''s Earthy Trinkets', 'Honest forms, perfectly imperfect. Using natural clay, my pieces bear the clear, unpolished marks of my fingertips. I invite you to embrace the authenticity and slight irregularity that makes handmade items feel truly warm and personal.', 17),
('Zen Paper Art', 'Where focused patience meets extraordinary detail. My complex 3D art is created by meticulously folding thousands of paper strips. Choose this art as a visual journey toward mindfulness and appreciation for astonishing, dedicated craft.', 18),
('Elio''s Light & Resin', 'Illuminating your personal history. I create bespoke lamps by embedding your most sentimental mementos (keys, flowers, trinkets) in clear resin. Turn your most cherished memories into the brightest, most beautiful source of light in your home.', 19),
('Mila Handmade Soaps', 'Mother''s love and purity in every bar. My cold-process soaps grew from a necessity to provide safe, natural care for my family. We use pure, local ingredients to offer you relief, nourishing care, and absolute peace of mind.', 20);

SELECT
    (SELECT user_id FROM users WHERE username = 'ZiaMadePH') AS ZiaMadePH_ID,
    (SELECT user_id FROM users WHERE username = 'AltheaCreates') AS AltheaCreates_ID,
    (SELECT user_id FROM users WHERE username = 'KaiGoods') AS KaiGoods_ID,
    (SELECT user_id FROM users WHERE username = 'MaelysWeave') AS MaelysWeave_ID,
    (SELECT user_id FROM users WHERE username = 'EthanLeather') AS EthanLeather_ID,
    (SELECT user_id FROM users WHERE username = 'ZoeyAtbp') AS ZoeyAtbp_ID,
    (SELECT user_id FROM users WHERE username = 'LiamPrint') AS LiamPrint_ID,
    (SELECT user_id FROM users WHERE username = 'LunaCrafted') AS LunaCrafted_ID,
    (SELECT user_id FROM users WHERE username = 'CieloScents') AS CieloScents_ID,
    (SELECT user_id FROM users WHERE username = 'NicoCeramics') AS NicoCeramics_ID,
    (SELECT user_id FROM users WHERE username = 'SkyeTextile') AS SkyeTextile_ID,
    (SELECT user_id FROM users WHERE username = 'AmariMetals') AS AmariMetals_ID,
    (SELECT user_id FROM users WHERE username = 'ChloeQuilts') AS ChloeQuilts_ID,
    (SELECT user_id FROM users WHERE username = 'JaviBuilds') AS JaviBuilds_ID,
    (SELECT user_id FROM users WHERE username = 'AvaPaints') AS AvaPaints_ID,
    (SELECT user_id FROM users WHERE username = 'XanderWares') AS XanderWares_ID,
    (SELECT user_id FROM users WHERE username = 'FreyaClay') AS FreyaClay_ID,
    (SELECT user_id FROM users WHERE username = 'ZenCraftsMNL') AS ZenCraftsMNL_ID,
    (SELECT user_id FROM users WHERE username = 'ElioLighting') AS ElioLighting_ID,
    (SELECT user_id FROM users WHERE username = 'MilaKape') AS MilaKape_ID;


-- 5. INSERT items 

INSERT INTO items (name, description, price, stock, shop_id, category_id) VALUES
-- Shop 1: The Zia Clay Studio (Home & Functional Ceramics - ID 1)
('Lola''s Legacy Coffee Mug', 'Hand-coiled mug using Kapampangan technique, finished in a smooth, modern white glaze. Perfectly weighted for comfort.', 850.00, 10, 1, 1),
('Pampanga Sunrise Pinch Bowl', 'Set of three small, earthy bowls, ideal for condiments or spices. Features exposed terracotta clay along the base.', 1200.00, 5, 1, 1),
('Heritage Coil-Built Vase', 'Tall, structural vase built entirely by hand-coiling. A statement piece that bridges ancient craft and modern interior design.', 4500.00, 3, 1, 1),
('The Zia Signature Dinner Plate', 'Large, flat plate with a subtle, intentional irregularity in the rim, glazed in deep, matte forest green.', 1500.00, 8, 1, 1),
('Earth''s Embrace Incense Holder', 'A small, organic piece designed to hold burning incense, inspired by the curvature of clay as it dries.', 650.00, 12, 1, 1),

-- Shop 2: Althea's Knit & Knot (Sustainable Textiles & Fiber Art - ID 2)
('Kapayapaan Weighted Throw', 'A large, densely knit throw blanket designed for comfort and anxiety relief. Crafted with therapeutic, repetitive stitches.', 7800.00, 4, 2, 2),
('Hinga Meditation Mat', 'A circular, crocheted mat made from recycled cotton rope, offering a soft, textured space for breathing and mindfulness.', 3200.00, 6, 2, 2),
('Resilience Texture Pillow Cover', 'A decorative cushion cover with intricate cable-knit patterns symbolizing strength and recovery.', 1800.00, 15, 2, 2),
('Therapy Yarn Keychain Set', 'Small, woven keychains made from yarn scraps. A pocket-sized reminder to pause and breathe.', 750.00, 20, 2, 2),
('Moms'' Collaborative Shawl', 'A lightweight shawl featuring panels knit by three different mothers, symbolizing community and shared purpose.', 4500.00, 7, 2, 2),

-- Shop 3: Kai's Minimalist Wood (Leather & Wood Goods - ID 3)
('The Architect''s Desk Organizer', 'Minimalist organizer made from reclaimed Narra wood. Features clean lines and multiple slots for essentials.', 2900.00, 9, 3, 3),
('Honest Scrap Coaster Set', 'Set of four coasters made entirely from wood offcuts and construction waste.', 1100.00, 18, 3, 3),
('Enduring Elegance Cutting Board', 'Solid block cutting board made from a single piece of reclaimed Philippine hardwood.', 3500.00, 6, 3, 3),
('Recycled Timber Catchall Tray', 'A simple, wide, low-profile tray for keys, phones, or wallet.', 2100.00, 11, 3, 3),
('Zero-Waste Planter Stand', 'Small, sturdy platform made from construction scrap, designed to elevate a ceramic planter.', 1600.00, 14, 3, 3),

-- Shop 4: Maëlys Fabric & Thread (Sustainable Textiles & Fiber Art - ID 2)
('100-Hour Waling-Waling Art', 'Intricate museum-quality embroidery capturing the vibrant life of the Philippine orchid. Certificate guarantees 100+ working hours.', 9500.00, 2, 4, 2),
('Patient Stitch Bird Brooch', 'A tiny, highly detailed, hand-stitched brooch featuring a native Philippine bird.', 1900.00, 10, 4, 2),
('Fauna Tapestry Wall Hanging', 'A medium-sized textile piece depicting a lush forest scene, created using hundreds of thousands of individual stitches.', 14000.00, 1, 4, 2),
('The Devotional Bookmark', 'A thin fabric bookmark featuring a miniature, precise floral embroidery.', 650.00, 25, 4, 2),
('Monochrome Insect Study', 'A small, black and white embroidery piece studying the geometry of a local insect.', 3800.00, 5, 4, 2),

-- Shop 5: Ethan's Leather Works (Leather & Wood Goods - ID 3)
('Marikina Heirloom Bifold Wallet', 'Hand saddle-stitched wallet made from vegetable-tanned cowhide. Designed to last decades, guaranteed for life.', 3400.00, 12, 5, 3),
('The Traveler''s Sentinel Pouch', 'A rugged, compact zippered pouch ideal for cables, passports, or small tools. Ages beautifully with use.', 4100.00, 8, 5, 3),
('Legacy Full-Grain Belt', 'A simple, durable leather belt cut from a single, high-quality hide, finished with a solid brass buckle.', 3800.00, 10, 5, 3),
('Desk Mat of Durability', 'A large, thick leather mat for the desktop, providing a smooth workspace and protecting the desk underneath.', 6200.00, 5, 5, 3),
('Personalized Cable Keeper Set', 'Set of three small leather snaps to manage wires and cables. Monogramming available.', 1050.00, 20, 5, 3),

-- Shop 6: Zoey's Resin Gems (Personal Accessories & Jewelry - ID 4)
('Immortality Petal Pendant', 'A single, vibrant petal from a Philippine orchid, perfectly suspended in a clear, round resin necklace.', 2200.00, 15, 6, 4),
('Palawan Sand Micro-Landscape Ring', 'A ring featuring tiny layers of sand, moss, and shells, creating a miniature world sealed within the resin dome.', 1950.00, 10, 6, 4),
('Ephemeral Beauty Stud Earrings', 'Tiny stud earrings featuring preserved moss and gold leaf, capturing the fleeting greenness of the wilderness.', 1400.00, 25, 6, 4),
('Botanical Micro-Museum Coasters', 'Set of four clear resin coasters embedded with dried ferns and flowers.', 3800.00, 6, 6, 4),
('Oceanic Flow Hair Pin', 'A long hair pin with blue-tinted resin embedded with seafoam and beach-combed elements.', 1650.00, 10, 6, 4),

-- Shop 7: Liam Letterpress Studio (Fine Art & Stationery - ID 5)
('The Tactile Thank You Card Set', 'A set of 10 thank you cards printed on thick cotton paper, featuring a deep, satisfying impression.', 1800.00, 30, 7, 5),
('Slower is Soulful Art Print', 'A small, black and white quote print affirming the value of slow craft.', 1500.00, 15, 7, 5),
('Hand-Fed Custom Stationery', 'Personalized letterhead and envelopes, individually hand-fed through the antique press for unmatched quality.', 4500.00, 5, 7, 5),
('The Legacy Coaster Set', 'Set of four thick-stock coasters featuring classic Filipino script and deep debossing.', 1100.00, 20, 7, 5),
('Vintage Manila Map Print', 'A historical map of Manila printed using a two-color letterpress technique on textured archival paper.', 2800.00, 10, 7, 5),

-- Shop 8: Luna & Stars Jewelry (Personal Accessories & Jewelry - ID 4)
('Custom Birth Constellation Necklace', 'A pendant featuring hand-set stones arranged to mirror the wearer''s birth star pattern.', 3900.00, 8, 8, 4),
('Solstice Moon Phase Ring', 'A sterling silver ring engraved with the exact moon phase from a significant date.', 3200.00, 10, 8, 4),
('Celestial Map Studs', 'Simple, geometric studs representing the major stars of the Philippine sky.', 2100.00, 18, 8, 4),
('Andromeda Stacking Bracelet', 'A delicate silver chain bracelet with tiny, spaced celestial charms.', 2500.00, 15, 8, 4),
('Cosmic Connection Locket', 'A locket with a high-polish finish, designed to hold a small photo and engraved with the wearer''s zodiac sign.', 4800.00, 7, 8, 4),

-- Shop 9: Cielo Aromatic Crafts (Aromatics & Wellness - ID 6)
('Sampaguita Dawn Soy Candle', 'Natural soy wax candle with a pure essential oil blend that perfectly captures the scent of morning.', 1400.00, 20, 9, 6),
('Bicol Sea Salt Air Reed Diffuser', 'A non-toxic, slow-release diffuser using local oils to bring the crisp, clean scent of the Bicol coast.', 1800.00, 15, 9, 6),
('Post-Rain Earth Musk Wax Melts', 'Small wax melts that evoke the deep, comforting, earthy smell of petrichor.', 850.00, 30, 9, 6),
('Gumamela & Honey Hand Balm', 'A rich, natural hand balm made with local beeswax and a hint of Gumamela floral essence.', 950.00, 25, 9, 6),
('Aromatherapy Travel Tin Set', 'Set of three small, portable candles: Dawn, Noon, and Dusk, each with a distinct Philippine scent profile.', 2500.00, 10, 9, 6),

-- Shop 10: Nico's Wheel & Glaze (Home & Functional Ceramics - ID 1)
('Wabi-Sabi Daily Coffee Mug', 'Hand-thrown mug with a deliberate, natural wobble and a unique crackle glaze. No two are exactly alike.', 950.00, 10, 10, 1),
('Honest Form Serving Platter', 'A wide, low serving platter with an intentionally asymmetrical shape, showcasing the marks of throwing.', 3600.00, 5, 10, 1),
('Proof of Hand Dinner Bowl Set', 'Set of two rustic, durable bowls designed for daily use. Their imperfection is proof of soulful creation.', 1800.00, 8, 10, 1),
('Artisan''s Thumbprint Sake Cups', 'A set of four tiny cups featuring the clear indentations of Nico''s thumb where the cup was pinched during throwing.', 1400.00, 12, 10, 1),
('Glaze Study Decorative Tile', 'A small, square tile used to test a new homemade glaze. A collector''s piece celebrating the unpredictability of fire.', 1200.00, 6, 10, 1),

-- Shop 11: Skye and Stitch (Sustainable Textiles & Fiber Art - ID 2)
('Reborn Barong Tagalog Clutch', 'A stylish clutch bag crafted from disassembled vintage Barong fabrics. Each piece carries a unique slice of history.', 2600.00, 10, 11, 2),
('Filipiniana Scrap Patchwork Pouch', 'A small zippered pouch made from a colorful, curated mosaic of old Filipiniana dress scraps.', 1500.00, 15, 11, 2),
('The Second Life Upcycled Scarf', 'A long scarf created by carefully piecing together undamaged sections of discarded luxury fabrics and silk.', 3100.00, 7, 11, 2),
('Textile History Wall Banner', 'A decorative hanging banner featuring layered, stitched sections of various Filipino textile remnants.', 4200.00, 4, 11, 2),
('Zero-Waste Cord Wraps', 'Set of small fabric wraps made from the smallest fabric scraps.', 800.00, 30, 11, 2),

-- Shop 12: Amari Fine Filigree (Personal Accessories & Jewelry - ID 4)
('Ancestral Filigree Drop Earrings', 'Delicate sterling silver drop earrings featuring intricate, lacelike metalwork.', 5500.00, 8, 12, 4),
('Survival of the Craft Ring', 'A substantial ring symbolizing the dedication required to keep filigree alive.', 4800.00, 6, 12, 4),
('Heirloom-Quality Filigree Brooch', 'A statement brooch crafted entirely from fine, hand-twisted silver wire.', 6200.00, 5, 12, 4),
('The Ilocos Bloom Pendant', 'A small, floral pendant designed using traditional filigree techniques learned from Ilocano masters.', 3500.00, 10, 12, 4),
('Metal Thread Dainty Bracelet', 'A delicate thin bracelet made of fine silver thread, perfect for stacking.', 2900.00, 15, 12, 4),

-- Shop 13: Chloe's Comfort Quilt (Heirloom & Custom Gifts - ID 7)
('The Generational Memory Quilt', 'Large, custom-commissioned quilt made from your loved ones'' significant fabric scraps and old clothing. Price varies.', 18000.00, 1, 13, 7),
('Heavy Comfort Lap Throw', 'A smaller, weighted quilt designed to provide a sense of security and comforting embrace while reading or resting.', 8500.00, 5, 13, 7),
('Family History Stitched Pillow', 'A large, decorative pillow made from patchwork blocks, ideal for displaying and cherishing small fabric memories.', 3500.00, 8, 13, 7),
('The Endurance Baby Quilt', 'A small, durable quilt made from high-quality cottons designed to be washed, loved, and passed down.', 4900.00, 6, 13, 7),
('Patchwork Table Runner', 'A colorful, narrow runner made from carefully selected fabric remnants, adding warmth and history to your dining table.', 2800.00, 10, 13, 7),

-- Shop 14: Javi Custom Furniture (Leather & Wood Goods - ID 3)
('The Patient-Crafted Console Table', 'Slim entry table made from Philippine hardwood, featuring impeccable joinery and a hand-oiled finish.', 16000.00, 2, 14, 3),
('Legacy Wood Hand-Sanded Stool', 'A sturdy, compact stool built to last a century. The smooth finish is the result of hours of hand-sanding.', 7500.00, 5, 14, 3),
('Anti-Disposable Investment Shelf', 'A minimalist floating shelf designed with traditional, durable joinery. Requires weeks of intentional creation.', 9800.00, 3, 14, 3),
('The Heirloom Cutting Board', 'An extra-thick, heavy-duty cutting board designed for professional use, meant to gather character and last forever.', 4500.00, 7, 14, 3),
('Woodworker''s Signature Pen Holder', 'A small, elegant desk accessory showcasing a flawless, hand-oiled finish on a block of Philippine mahogany.', 2100.00, 10, 14, 3),

-- Shop 15: Ava’s Painted Stones (Fine Art & Stationery - ID 5)
('River Stone Miniature Landscape', 'A smooth, natural river stone painted with a detailed, miniature scene of a Filipino rice terrace or beach.', 1500.00, 15, 15, 5),
('Found Beauty Hand-Painted Wildlife Rock', 'A naturally-shaped stone featuring a lifelike painting of a Philippine Eagle or local butterfly.', 1800.00, 10, 15, 5),
('Underfoot Canvas Custom Pet Portrait', 'Commission a detailed miniature portrait of a beloved pet, painted on a smooth, naturally-formed stone. Price varies.', 2500.00, 5, 15, 5),
('Flora & Fauna Stone Garden Markers', 'Set of three flat stones painted with local herbs and flowers, perfect for marking plants or decorating windowsills.', 1900.00, 12, 15, 5),
('Painted Pebble Paperweight', 'A simple, elegant painted stone used to anchor papers, adding a touch of natural art to the workspace.', 1100.00, 18, 15, 5),

-- Shop 16: Xander's Modern Macrame (Sustainable Textiles & Fiber Art - ID 2)
('Rhythmic Form Wall Hanging', 'A large, complex macrame piece focusing on deep geometry and structure, translating musical rhythm into knots.', 6800.00, 5, 16, 2),
('Geometry of Emotion Planter Hanger', 'A sturdy macrame plant hanger featuring complex knot patterns.', 2900.00, 10, 16, 2),
('The Quiet Strength Room Divider', 'A large, semi-transparent macrame panel used to define space without fully blocking light.', 12000.00, 2, 16, 2),
('Sensory Texture Trivet Set', 'A set of three thick, durable knotted trivets for hot items.', 1500.00, 15, 16, 2),
('Minimalist Knot Keychain', 'A small keychain demonstrating a single, complex knot pattern.', 750.00, 20, 16, 2),

-- Shop 17: Freya's Earthy Trinkets (Home & Functional Ceramics - ID 1)
('Perfectly Imperfect Jewelry Dish', 'A small, organic jewelry dish featuring clear fingertip marks and a slightly uneven rim.', 750.00, 15, 17, 1),
('Honest Form Hand-Shaped Soap Tray', 'A natural clay tray for bar soap, intentionally irregular and uncoated to embrace its earthy texture.', 650.00, 20, 17, 1),
('The Authentic Bowl', 'A medium-sized decorative bowl with a heavy base and an intentionally asymmetrical shape.', 1800.00, 10, 17, 1),
('Organic Clay Planter', 'A small, porous planter designed to mimic the raw, rough texture of earth, perfect for small succulents.', 900.00, 15, 17, 1),
('Earthy Texture Candle Vessel', 'A simple, unglazed clay vessel for small candles, designed to be reused and touched.', 1100.00, 12, 17, 1),

-- Shop 18: Zen Paper Art (Fine Art & Stationery - ID 5)
('Mindfulness Folded Paper Wall Panel', 'A large, three-dimensional geometric art piece created from thousands of meticulously folded paper units.', 7500.00, 3, 18, 5),
('Focused Patience Quilled Art Piece', 'A small, detailed piece made entirely of tiny, rolled paper strips, requiring hours of intense concentration.', 2900.00, 6, 18, 5),
('Extraordinary Detail Paper Frame', 'A small photo frame decorated with hundreds of precise, hand-rolled paper flowers and designs.', 2200.00, 8, 18, 5),
('The Calming Grid Art Print', 'A limited edition print of a complex paper grid pattern, representing discipline and mental clarity.', 1500.00, 15, 18, 5),
('Geometric Paper Sculpture', 'A small, freestanding paper sculpture made of interlocking, folded modules. A desk ornament for focus.', 1800.00, 10, 18, 5),

-- Shop 19: Elio's Light & Resin (Heirloom & Custom Gifts - ID 7)
('Commission: Illuminated Memory Lamp', 'Bespoke large lamp where the client’s sentimental objects are embedded and lit from within. Price varies (commission).', 15000.00, 1, 19, 7),
('Bespoke History Cube Nightlight', 'A small, personalized nightlight cube embedding small objects provided by the client.', 5800.00, 5, 19, 7),
('The Personal Talisman Desk Light', 'A small resin table lamp embedding personalized text or a small, symbolic plant, illuminating a daily ritual.', 7500.00, 4, 19, 7),
('Floral Keepsake Resin Pendant', 'A necklace pendant made by sealing the client’s own dried flowers in resin.', 3200.00, 10, 19, 7),
('Glow of Memory Coaster Set', 'Set of four resin coasters where the client provides small, flat paper mementos to be embedded.', 4100.00, 6, 19, 7),

-- Shop 20: Mila Handmade Soaps (Aromatics & Wellness - ID 6)
('Mother''s Purity Coconut Milk Bar', 'A pure, unscented cold-process soap made with extra coconut milk. Ideal for sensitive skin and babies.', 350.00, 50, 20, 6),
('Gentle Care Local Herb Soap Bar', 'A soap bar infused with locally sourced chamomile and oatmeal, providing soothing relief for allergic or irritated skin.', 380.00, 40, 20, 6),
('Peace of Mind Calming Bath Soak', 'A blend of natural salts and pure lavender oil, designed to promote relaxation.', 750.00, 20, 20, 6),
('Nourishing Shea Butter Lip Balm', 'A small tin of balm made with high-quality shea butter and a touch of local beeswax for intense moisture.', 450.00, 30, 20, 6),
('Tropical Citrus Kitchen Bar', 'A large, dense soap bar with a strong citrus scent and exfoliating grit, designed to remove cooking odors and grime.', 400.00, 35, 20, 6);

SELECT
    (SELECT shop_id FROM shops WHERE name = 'The Zia Clay Studio') AS ZiaClayStudio_ID,
    (SELECT shop_id FROM shops WHERE name = 'Althea''s Knit & Knot') AS AltheasKnitKnot_ID,
    (SELECT shop_id FROM shops WHERE name = 'Kai''s Minimalist Wood') AS KaisMinimalistWood_ID,
    (SELECT shop_id FROM shops WHERE name = 'Maëlys Fabric & Thread') AS MaelysFabricThread_ID,
    (SELECT shop_id FROM shops WHERE name = 'Ethan''s Leather Works') AS EthansLeatherWorks_ID,
    (SELECT shop_id FROM shops WHERE name = 'Zoey''s Resin Gems') AS ZoeysResinGems_ID,
    (SELECT shop_id FROM shops WHERE name = 'Liam Letterpress Studio') AS LiamLetterpressStudio_ID,
    (SELECT shop_id FROM shops WHERE name = 'Luna & Stars Jewelry') AS LunaStarsJewelry_ID,
    (SELECT shop_id FROM shops WHERE name = 'Cielo Aromatic Crafts') AS CieloAromaticCrafts_ID,
    (SELECT shop_id FROM shops WHERE name = 'Nico''s Wheel & Glaze') AS NicosWheelGlaze_ID,
    (SELECT shop_id FROM shops WHERE name = 'Skye and Stitch') AS SkyeandStitch_ID,
    (SELECT shop_id FROM shops WHERE name = 'Amari Fine Filigree') AS AmariFineFiligree_ID,
    (SELECT shop_id FROM shops WHERE name = 'Chloe''s Comfort Quilt') AS ChloesComfortQuilt_ID,
    (SELECT shop_id FROM shops WHERE name = 'Javi Custom Furniture') AS JaviCustomFurniture_ID,
    (SELECT shop_id FROM shops WHERE name = 'Ava’s Painted Stones') AS AvasPaintedStones_ID,
    (SELECT shop_id FROM shops WHERE name = 'Xander''s Modern Macrame') AS XandersModernMacrame_ID,
    (SELECT shop_id FROM shops WHERE name = 'Freya''s Earthy Trinkets') AS FreyasEarthyTrinkets_ID,
    (SELECT shop_id FROM shops WHERE name = 'Zen Paper Art') AS ZenPaperArt_ID,
    (SELECT shop_id FROM shops WHERE name = 'Elio''s Light & Resin') AS EliosLightResin_ID,
    (SELECT shop_id FROM shops WHERE name = 'Mila Handmade Soaps') AS MilaHandmadeSoaps_ID,
    
    (SELECT id FROM category WHERE name = 'Home & Functional Ceramics') AS HomeCeramics_ID,
    (SELECT id FROM category WHERE name = 'Sustainable Textiles & Fiber Art') AS TextilesFiberArt_ID,
    (SELECT id FROM category WHERE name = 'Leather & Wood Goods') AS LeatherWoodGoods_ID,
    (SELECT id FROM category WHERE name = 'Personal Accessories & Jewelry') AS PersonalJewelry_ID,
    (SELECT id FROM category WHERE name = 'Fine Art & Stationery') AS FineArtStationery_ID,
    (SELECT id FROM category WHERE name = 'Aromatics & Wellness') AS AromaticsWellness_ID,
    (SELECT id FROM category WHERE name = 'Heirloom & Custom Gifts') AS HeirloomCustomGifts_ID;

COMMIT;