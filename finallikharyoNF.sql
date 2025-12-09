-------- 1NF --------

DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS shops CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 1. USERS TABLE (1NF)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(150) NOT NULL DEFAULT 'dummy_hash',
    is_admin BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'default_profile.jpg'
);

-- 2. ADDRESSES TABLE (1NF)
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A',
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000'
);

-- 3. SHOPS TABLE (1NF)
CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    shop_category VARCHAR(150),
    description TEXT,
    owner_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_shop_id INTEGER REFERENCES shops(shop_id) ON DELETE SET NULL
);

-- 4. ITEMS TABLE (1NF)
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    img_url VARCHAR(250),
    shop_id INTEGER NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE
);


-- 1NF DATA INSERTION
INSERT INTO users (username, password_hash, is_admin, first_name, last_name, gender, birthdate, contact_num, bio, profile_img_url) VALUES
('ZiaMadePH', 'dummy_hash', TRUE, 'Zia', 'Gonzales', 'Female', '1995-03-12', '09171234567', 'zia.jpg'),
('AltheaCreates', 'dummy_hash', TRUE, 'Althea', 'Ramos', 'Female', '1992-08-21', '09172345678', 'althea.jpg'),
('KaiGoods', 'dummy_hash', TRUE, 'Kai', 'Tan', 'Male', '1990-11-05', '09173456789', 'kai.jpg'),
('MaelysWeave', 'dummy_hash', TRUE, 'Maëlys', 'Santos', 'Female', '1998-04-19', '09174567890', 'maelys.jpg'),
('EthanLeather', 'dummy_hash', TRUE, 'Ethan', 'Lopez', 'Male', '1993-01-25', '09175678901', 'ethan.jpg'),
('ZoeyAtbp', 'dummy_hash', TRUE, 'Zoey', 'Villanueva', 'Female', '2001-07-30', '09176789012', 'zoey.jpg'),
('LiamPrint', 'dummy_hash', TRUE, 'Liam', 'De La Cruz', 'Male', '1996-10-01', '09177890123', 'liam.jpg'),
('LunaCrafted', 'dummy_hash', TRUE, 'Luna', 'Reyes', 'Female', '1997-12-14', '09178901234', 'luna.jpg'),
('CieloScents', 'dummy_hash', TRUE, 'Cielo', 'Mendoza', 'Female', '1991-05-08', '09179012345', 'cielo.jpg'),
('NicoCeramics', 'dummy_hash', TRUE, 'Nico', 'Lim', 'Male', '1994-06-28', '09181234567', 'nico.jpg'),
('SkyeTextile', 'dummy_hash', TRUE, 'Skye', 'Garcia', 'Female', '1999-02-03', '09182345678', 'skye.jpg'),
('AmariMetals', 'dummy_hash', TRUE, 'Amari', 'Dela Rosa', 'Female', '1990-09-17', '09183456789', 'amari.jpg'),
('ChloeQuilts', 'dummy_hash', TRUE, 'Chloe', 'Aquino', 'Female', '1993-03-29', '09184567890', 'chloe.jpg'),
('JaviBuilds', 'dummy_hash', TRUE, 'Javi', 'Torres', 'Male', '1997-07-07', '09185678901', 'javi.jpg'),
('AvaPaints', 'dummy_hash', TRUE, 'Ava', 'Salazar', 'Female', '2000-04-11', '09186789012', 'ava.jpg'),
('XanderWares', 'dummy_hash', TRUE, 'Xander', 'Bautista', 'Male', '1995-08-04', '09187890123', 'xander.jpg'),
('FreyaClay', 'dummy_hash', TRUE, 'Freya', 'Castro', 'Female', '1991-05-22', '09188901234', 'freya.jpg'),
('ZenCraftsMNL', 'dummy_hash', TRUE, 'Zen', 'Ramos', 'Male', '1998-09-10', '09189012345', 'zen.jpg'),
('ElioLighting', 'dummy_hash', TRUE, 'Elio', 'Fernandez', 'Male', '1994-12-03', '09191234567', 'elio.jpg'),
('MilaKape', 'dummy_hash', TRUE, 'Mila', 'Corpuz', 'Female', '1992-06-16', '09192345678', 'mila.jpg');

INSERT INTO addresses (user_id, street_address, city, province, zip_code) VALUES
(1, '88 Duyan St., San Roque', 'San Fernando', 'Pampanga', '2000'),
(2, '12 Munting Lupa, Poblacion', 'Quezon City', 'Metro Manila', '1100'),
(3, 'Blk 5 Lot 14 Aklan Rd., Holy Spirit', 'Cebu City', 'Cebu', '6000'),
(4, '77 Makisig Ave., San Isidro', 'Makati', 'Metro Manila', '1200'),
(5, '22 Shoe Road, Concepcion Uno', 'Marikina', 'Metro Manila', '1800'),
(6, '9 Palawan Way, Sta. Monica', 'Puerto Princesa', 'Palawan', '5300'),
(7, '4 Antique Press Lane, Sampaloc', 'Manila', 'Metro Manila', '1008'),
(8, '16 Constellation Blvd., Kanan', 'Legazpi', 'Albay', '4500'),
(9, '33 Aromatics Circle, Purok 5', 'Naga City', 'Camarines Sur', '4400'),
(10, '10 Glaze Trail, Malinta', 'Valenzuela', 'Metro Manila', '1440'),
(11, '5 Barong Thread, San Jose', 'Baguio City', 'Benguet', '2600'),
(12, '1 Filigree St., Poblacion', 'Vigan', 'Ilocos Sur', '2700'),
(13, '18 Comfort Lane, Commonwealth', 'Quezon City', 'Metro Manila', '1121'),
(14, '6 Joinery Road, Sta. Cruz', 'Davao City', 'Davao del Sur', '8000'),
(15, '15 River Stone Path, San Agustin', 'Tagaytay City', 'Cavite', '4120'),
(16, '22 Knotting Loop, Talisay', 'Bacolod City', 'Negros Occidental', '6100'),
(17, '7 Earthy Hill, Polo', 'Iloilo City', 'Iloilo', '5000'),
(18, '99 Folding Point, Pinagbuhatan', 'Pasig', 'Metro Manila', '1600'),
(19, '3 Resin Light, Mambaling', 'Cebu City', 'Cebu', '6004'),
(20, '1 Coconut Oil Dr., Calamba', 'Lucena City', 'Quezon', '4301');

INSERT INTO shops (owner_id, name, shop_category, description) VALUES
(1, 'The Zia Clay Studio', 'Home & Functional Ceramics', 'Preserving the legacy of Pampanga in modern form. We fuse age-old Kapampangan hand-building techniques with contemporary design. Every piece carries the intentional mark of human hands, ensuring that our heritage and the warmth of tradition enrich your modern home. '),
(2, 'Althea''s Knit & Knot', 'Sustainable Textiles & Fiber Art', 'Knitting therapy into every stitch. Our throws and accessories are created with mindfulness, offering comfort and peace (Kapayapaan). Choosing our fiber art supports mothers who turn anxiety into beautiful, therapeutic, handcrafted textile works. '),
(3, 'Kai''s Minimalist Wood', 'Leather & Wood Goods', 'Sustainable elegance from salvaged history. We refuse waste, creating minimalist designs solely from reclaimed Philippine hardwoods. Our commitment is to honesty, integrity, and building heirloom pieces that respect the material and last a lifetime. '),
(4, 'Maëlys Fabric & Thread', 'Sustainable Textiles & Fiber Art', 'Where patience is the medium. We specialize in intricate embroidery, dedicating over a hundred hours to capturing the detail of local flora and fauna. Buy the passage of time—a tangible tribute to Filipino nature and slow, devotional craftsmanship.'),
(5, 'Ethan''s Leather Works', 'Leather & Wood Goods', 'Heirlooms built to defy fast fashion. Hand-stitched in Marikina using only honest, vegetable-tanned leather. We offer a lifetime repair guarantee because we believe true quality is a promise of enduring companionship, not disposable trends.'),
(6, 'Zoey''s Resin Gems', 'Personal Accessories & Jewelry', 'Immortality for nature''s most delicate moments. I collect and preserve tiny elements of the Philippine wilderness—petals, moss, sand—in crystal-clear resin. Wear a micro-museum, a timeless piece of our islands'' fleeting beauty. '),
(7, 'Liam Letterpress Studio', 'Fine Art & Stationery', 'Reviving the luxurious, tactile art of communication. We use antique presses to create stationery with a deep, physical impression. Choose the deliberate, soulful elegance of letterpress over the flatness of digital speed.'),
(8, 'Luna & Stars Jewelry', 'Personal Accessories & Jewelry', 'Jewelry as a personal celestial map. We hand-set precious stones to replicate your birth constellation or a significant moon phase. Our pieces are more than adornment; they are deeply personal talismans that track your unique cosmic history.'),
(9, 'Cielo Aromatic Crafts', 'Aromatics & Wellness', 'The authentic scent of the Philippines, bottled. We reject synthetics, using natural waxes and local oils to capture the real aromas of Sampaguita, sea air, and earth. Light a true olfactory journey back to your favorite Filipino memory.'),
(10, 'Nico''s Wheel & Glaze', 'Home & Functional Ceramics', 'Embracing Wabi-Sabi: The beauty of the human touch. I hand-throw every ceramic piece, celebrating the slight wobble and unique glaze crackle that a machine would reject. Choose character and honest form over cold, factory perfection. '),
(11, 'Skye and Stitch', 'Sustainable Textiles & Fiber Art', 'Giving history a second life. We meticulously deconstruct and reassemble damaged Barongs and vintage textiles into modern accessories. Our craft is a beautiful stand against textile waste and a celebration of rebirth.'),
(12, 'Amari Fine Filigree', 'Personal Accessories & Jewelry', 'Funding the survival of a national treasure. My jewelry uses centuries-old Filigree techniques, meticulously twisting metal threads by hand. You are investing in the survival of a beautiful, vanishing Filipino heritage craft. '),
(13, 'Chloe''s Comfort Quilt', 'Heirloom & Custom Gifts', 'Stitching family memories into lasting comfort. Our quilts are designed as heavy, comforting heirlooms, combining fabric scraps that represent shared history. We offer a generational embrace, built to gather memories for decades. '),
(14, 'Javi Custom Furniture', 'Leather & Wood Goods', 'Heirloom quality built with necessary patience. I refuse to compromise on the time required for perfection. We hand-sand and join every piece to create resilient, soulful furniture—a quiet stand against disposable consumerism. '),
(15, 'Ava’s Painted Stones', 'Fine Art & Stationery', 'Finding art in the unexpected, natural canvas. I use perfectly shaped river stones as my medium for detailed miniature landscapes. My work reminds you that profound beauty can be found anywhere, even in a simple rock underfoot. '),
(16, 'Xander''s Modern Macrame', 'Sustainable Textiles & Fiber Art', 'Translating rhythm and feeling into geometric form. I specialize in complex macrame patterns, creating texture and structure that appeal to all the senses. Experience the quiet strength and sophistication of the knotted human hand. '),
(17, 'Freya''s Earthy Trinkets', 'Home & Functional Ceramics', 'Honest forms, perfectly imperfect. Using natural clay, my pieces bear the clear, unpolished marks of my fingertips. I invite you to embrace the authenticity and slight irregularity that makes handmade items feel truly warm and personal. '),
(18, 'Zen Paper Art', 'Fine Art & Stationery', 'Where focused patience meets extraordinary detail. My complex 3D art is created by meticulously folding thousands of paper strips. Choose this art as a visual journey toward mindfulness and appreciation for astonishing, dedicated craft. '),
(19, 'Elio''s Light & Resin', 'Heirloom & Custom Gifts', 'Illuminating your personal history. I create bespoke lamps by embedding your most sentimental mementos (keys, flowers, trinkets) in clear resin. Turn your most cherished memories into the brightest, most beautiful source of light in your home.'),
(20, 'Mila Handmade Soaps', 'Aromatics & Wellness', 'Mother''s love and purity in every bar. My cold-process soaps grew from a necessity to provide safe, natural care for my family. We use pure, local ingredients to offer you relief, nourishing care, and absolute peace of mind.');

INSERT INTO items (shop_id, name, description, price, stock, img_url) VALUES
-- Shop 1: The Zia Clay Studio
(1,'Lola''s Legacy Coffee Mug','Hand-coiled mug using Kapampangan technique, finished in a smooth, modern white glaze. Perfectly weighted for comfort.',850.00,10,'zia_mug.jpg'),
(1,'Pampanga Sunrise Pinch Bowl Set','Set of three small, earthy bowls, ideal for condiments or spices. Features exposed terracotta clay along the base.',1200.00,5,'zia_pinch.jpg'),
(1,'Heritage Coil-Built Vase','Tall, structural vase built entirely by hand-coiling. A statement piece that bridges ancient craft and modern interior design.',4500.00,3,'zia_vase.jpg'),
(1,'The Zia Signature Dinner Plate','Large, flat plate with a subtle, intentional irregularity in the rim, glazed in deep, matte forest green.',1500.00,8,'zia_plate.jpg'),
(1,'Earth''s Embrace Incense Holder','A small, organic piece designed to hold burning incense. Its form is inspired by the curvature of the clay as it dries.',650.00,12,'zia_incense.jpg'),

-- Shop 2: Althea''s Knit & Knot
(2,'Kapayapaan Weighted Throw','A large, densely knit throw blanket designed for comfort and anxiety relief. Crafted with therapeutic, repetitive stitches.',7800.00,4,'althea_throw.jpg'),
(2,'Hinga Meditation Mat','A circular, crocheted mat made from recycled cotton rope, offering a soft, textured space for breathing and mindfulness.',3200.00,6,'althea_mat.jpg'),
(2,'Resilience Texture Pillow Cover','A decorative cushion cover with intricate, complex cable-knit patterns, symbolizing strength and recovery.',1800.00,15,'althea_pillow.jpg'),
(2,'Therapy Yarn Keychain Set','Small, woven keychains made from yarn scraps. A pocket-sized reminder to pause and breathe throughout the day.',750.00,20,'althea_key.jpg'),
(2,'Moms'' Collaborative Shawl','A lightweight shawl featuring panels knit by three different mothers, symbolizing community and shared purpose.',4500.00,7,'althea_shawl.jpg'),

-- Shop 3: Kai''s Minimalist Wood
(3,'The Architect''s Desk Organizer','Minimalist organizer made from reclaimed Narra wood. Features clean lines and multiple slots for essentials.',2900.00,9,'kai_org.jpg'),
(3,'Honest Scrap Coaster Set','Set of four coasters made entirely from wood offcuts and construction waste. Each coaster’s grain tells a unique, salvaged story.',1100.00,18,'kai_coaster.jpg'),
(3,'Enduring Elegance Cutting Board','Solid block cutting board made from a single piece of reclaimed Philippine hardwood, built to last generations.',3500.00,6,'kai_board.jpg'),
(3,'Recycled Timber Catchall Tray','A simple, wide, low-profile tray for keys, phones, or wallets. Its beauty is in its respect for the original material.',2100.00,11,'kai_tray.jpg'),
(3,'Zero-Waste Planter Stand','Small, sturdy platform made from construction scrap, designed to elevate a ceramic planter or display object.',1600.00,14,'kai_stand.jpg'),

-- Shop 4: Maëlys Fabric & Thread
(4,'100-Hour Waling-Waling Art','Intricate, museum-quality embroidery capturing the vibrant life of the Philippine orchid. Certificate guarantees 100+ working hours.',9500.00,2,'maelys_orchid.jpg'),
(4,'Patient Stitch Bird Brooch','A tiny, highly detailed, hand-stitched brooch featuring a native Philippine bird. A wearable testament to dedication.',1900.00,10,'maelys_bird.jpg'),
(4,'Fauna Tapestry Wall Hanging','A medium-sized textile piece depicting a lush forest scene, created using hundreds of thousands of individual stitches.',14000.00,1,'maelys_tapestry.jpg'),
(4,'The Devotional Bookmark','A thin fabric bookmark featuring a miniature, precise floral embroidery. For slow readers who appreciate slow craft.',650.00,25,'maelys_bookmark.jpg'),
(4,'Monochrome Insect Study','A small, black and white embroidery piece studying the geometry of a local insect. Focus on line and form.',3800.00,5,'maelys_insect.jpg'),

-- Shop 5: Ethan''s Leather Works
(5,'Marikina Heirloom Bifold Wallet','Hand saddle-stitched wallet made from vegetable-tanned cowhide. Designed to last decades, guaranteed for life.',3400.00,12,'ethan_wallet.jpg'),
(5,'The Traveler''s Sentinel Pouch','A rugged, compact zippered pouch ideal for cables, passports, or small tools. Ages beautifully with use.',4100.00,8,'ethan_pouch.jpg'),
(5,'Legacy Full-Grain Belt','A simple, durable leather belt cut from a single, high-quality hide, finished with a solid brass buckle.',3800.00,10,'ethan_belt.jpg'),
(5,'Desk Mat of Durability','A large, thick leather mat for the desktop, providing a smooth workspace and protecting the desk underneath.',6200.00,5,'ethan_deskmat.jpg'),
(5,'Personalized Cable Keeper Set','Set of three small leather snaps to manage wires and cables. Monogramming available to personalize your gear.',1050.00,20,'ethan_cable.jpg'),

-- Shop 6: Zoey''s Resin Gems
(6,'Immortality Petal Pendant','A single, vibrant petal from a Philippine orchid, perfectly suspended in a clear, round resin necklace.',2200.00,15,'zoey_pendant.jpg'),
(6,'Palawan Sand Micro-Landscape Ring','A ring featuring tiny layers of sand, moss, and shells, creating a miniature world sealed within the resin dome.',1950.00,10,'zoey_ring.jpg'),
(6,'Ephemeral Beauty Stud Earrings','Tiny stud earrings featuring preserved moss and gold leaf, capturing the fleeting greenness of the wilderness.',1400.00,25,'zoey_studs.jpg'),
(6,'Botanical Micro-Museum Coasters','Set of four clear resin coasters embedded with dried ferns and flowers. Protects surfaces with preserved nature.',3800.00,6,'zoey_coasters.jpg'),
(6,'Oceanic Flow Hair Pin','A long hair pin with blue-tinted resin embedded with seafoam and beach-combed elements.',1650.00,10,'zoey_hairpin.jpg'),

-- Shop 7: Liam Letterpress Studio
(7,'The Tactile Thank You Card Set','A set of 10 thank you cards printed on thick cotton paper, featuring a deep, satisfying impression that you can feel.',1800.00,30,'liam_cards.jpg'),
(7,'“Slower is Soulful” Art Print','A small, black and white quote print affirming the value of slow craft, perfect for a studio wall.',1500.00,15,'liam_print.jpg'),
(7,'Hand-Fed Custom Stationery','Personalized letterhead and envelopes, individually hand-fed through the antique press for unmatched quality.',4500.00,5,'liam_stationery.jpg'),
(7,'The Legacy Coaster Set','Set of four thick-stock coasters featuring classic Filipino script and deep debossing.',1100.00,20,'liam_coaster.jpg'),
(7,'Vintage Manila Map Print','A historical map of Manila printed using a two-color letterpress technique on textured archival paper.',2800.00,10,'liam_map.jpg'),

-- Shop 8: Luna & Stars Jewelry
(8,'Custom Birth Constellation Necklace','A pendant featuring hand-set cubic zirconia stones arranged precisely to mirror the wearer''s birth star pattern.',3900.00,8,'luna_const.jpg'),
(8,'Solstice Moon Phase Ring','A sterling silver ring engraved with the exact moon phase from a significant date (wedding, graduation, etc.).',3200.00,10,'luna_moon.jpg'),
(8,'Celestial Map Studs','Simple, geometric studs representing the major stars in the Philippine sky, designed to be worn daily as a talisman.',2100.00,18,'luna_studs.jpg'),
(8,'Andromeda Stacking Bracelet','A delicate silver chain bracelet with tiny, spaced celestial charms inspired by the Andromeda galaxy.',2500.00,15,'luna_bracelet.jpg'),
(8,'Cosmic Connection Locket','A locket with a high-polish finish, designed to hold a small photo and engraved with the wearer''s zodiac sign.',4800.00,7,'luna_locket.jpg'),

-- Shop 9: Cielo Aromatic Crafts
(9,'Sampaguita Dawn Soy Candle','Natural soy wax candle with a pure essential oil blend that perfectly captures the complex, intoxicating scent of the morning air.',1400.00,20,'cielo_candle.jpg'),
(9,'Bicol Sea Salt Air Reed Diffuser','A non-toxic, slow-release diffuser using local oils to bring the crisp, clean scent of the Bicol coast into your home.',1800.00,15,'cielo_diffuser.jpg'),
(9,'Post-Rain Earth Musk Wax Melts','Small wax melts that evoke the deep, comforting, earthy smell of petrichor (rain on dry ground) and tropical musk.',850.00,30,'cielo_melts.jpg'),
(9,'Gumamela & Honey Hand Balm','A rich, natural hand balm made with local beeswax and a hint of sweet Gumamela floral essence.',950.00,25,'cielo_balm.jpg'),
(9,'Aromatherapy Travel Tin Set','Set of three small, portable candles: Dawn, Noon, and Dusk, each with a distinct Philippine scent profile.',2500.00,10,'cielo_travel.jpg'),

-- Shop 10: Nico''s Wheel & Glaze
(10,'Wabi-Sabi Daily Coffee Mug','Hand-thrown mug with a deliberate, natural wobble and a unique crackle glaze. No two are exactly alike.',950.00,10,'nico_mug.jpg'),
(10,'Honest Form Serving Platter','A wide, low serving platter with an intentionally asymmetrical shape, showcasing the clear marks of the throwing process.',3600.00,5,'nico_platter.jpg'),
(10,'Proof of Hand Dinner Bowl Set','Set of two rustic, durable bowls designed for daily use. Their imperfection is proof of their soulful creation.',1800.00,8,'nico_bowls.jpg'),
(10,'Artisan''s Thumbprint Sake Cups','A set of four tiny cups featuring the clear indentations of Nico''s thumb where the cup was pinched during throwing.',1400.00,12,'nico_sake.jpg'),
(10,'Glaze Study Decorative Tile','A small, square tile used to test a new homemade glaze. A collector''s piece celebrating the unpredictability of fire.',1200.00,6,'nico_tile.jpg'),

-- Shop 11: Skye and Stitch
(11,'Reborn Barong Tagalog Clutch','A stylish clutch bag crafted from disassembled vintage Barong fabrics. Each piece carries a unique slice of history.',2600.00,10,'skye_clutch.jpg'),
(11,'Filipiniana Scrap Patchwork Pouch','A small zippered pouch made from a colorful, curated mosaic of old Filipiniana dress scraps.',1500.00,15,'skye_pouch.jpg'),
(11,'The Second Life Upcycled Scarf','A long scarf created by carefully piecing together undamaged sections of discarded luxury fabrics and silk.',3100.00,7,'skye_scarf.jpg'),
(11,'Textile History Wall Banner','A decorative hanging banner featuring layered, stitched sections of various Filipino textile remnants.',4200.00,4,'skye_banner.jpg'),
(11,'Zero-Waste Cord Wraps','Set of small fabric wraps made from the smallest fabric scraps. Perfect for keeping earphones and cords tidy.',800.00,30,'skye_wraps.jpg'),

-- Shop 12: Amari Fine Filigree
(12,'Ancestral Filigree Drop Earrings','Delicate sterling silver drop earrings featuring the intricate, lacelike metalwork of traditional Filipino Filigree.',5500.00,8,'amari_earrings.jpg'),
(12,'Survival of the Craft Ring','A substantial ring featuring a central filigree dome, symbolizing the dedication required to keep this beautiful craft alive.',4800.00,6,'amari_ring.jpg'),
(12,'Heirloom-Quality Filigree Brooch','A statement brooch crafted entirely from fine, hand-twisted silver wire. An elegant piece of history.',6200.00,5,'amari_brooch.jpg'),
(12,'The Ilocos Bloom Pendant','A small, floral pendant designed using traditional Filigree techniques learned from Ilocano masters.',3500.00,10,'amari_pendant.jpg'),
(12,'Metal Thread Dainty Bracelet','A delicate, thin bracelet made of fine silver thread, perfect for stacking and celebrating the precision of the craft.',2900.00,15,'amari_bracelet.jpg'),

-- Shop 13: Chloe's Comfort Quilt
(13,'The Generational Memory Quilt','Large, custom-commissioned quilt made from your loved ones'' significant fabric scraps and old clothing. (Price Varies)',18000.00,1,'chloe_memory.jpg'),
(13,'Heavy Comfort Lap Throw','A smaller, weighted quilt designed to provide a sense of security and a comforting embrace while reading or resting.',8500.00,5,'chloe_lap.jpg'),
(13,'Family History Stitched Pillow','A large, decorative pillow made from patchwork blocks, ideal for displaying and cherishing small fabric memories.',3500.00,8,'chloe_pillow.jpg'),
(13,'The Endurance Baby Quilt','A small, durable quilt made from high-quality cottons, designed to be washed, loved, and passed down through generations.',4900.00,6,'chloe_baby.jpg'),
(13,'Patchwork Table Runner','A colorful, narrow runner made from carefully selected fabric remnants, adding warmth and history to your dining table.',2800.00,10,'chloe_runner.jpg'),

-- Shop 14: Javi Custom Furniture
(14,'The Patient-Crafted Console Table','Slim entry table made from Philippine hardwood, featuring impeccable joinery and a luxurious, hand-oiled finish.',16000.00,2,'javi_console.jpg'),
(14,'Legacy Wood Hand-Sanded Stool','A sturdy, compact stool built to last a century. The smooth finish is the result of hours of hand-sanding.',7500.00,5,'javi_stool.jpg'),
(14,'Anti-Disposable Investment Shelf','A minimalist floating shelf designed with traditional, durable joinery. Requires weeks of intentional creation.',9800.00,3,'javi_shelf.jpg'),
(14,'The Heirloom Cutting Board','An extra-thick, heavy-duty cutting board designed for professional use, meant to gather character and last forever.',4500.00,7,'javi_board.jpg'),
(14,'Woodworker''s Signature Pen Holder','A small, elegant desk accessory showcasing a flawless, hand-oiled finish on a block of Philippine mahogany.',2100.00,10,'javi_pen.jpg'),

-- Shop 15: Ava’s Painted Stones
(15,'River Stone Miniature Landscape','A smooth, natural river stone painted with a detailed, miniature scene of a Filipino rice terrace or beach.',1500.00,15,'ava_landscape.jpg'),
(15,'Found Beauty Hand-Painted Wildlife Rock','A naturally-shaped stone featuring a lifelike painting of a Philippine Eagle or local butterfly.',1800.00,10,'ava_eagle.jpg'),
(15,'Underfoot Canvas Custom Pet Portrait','Commission a detailed miniature portrait of a beloved pet, painted on a smooth, naturally-formed stone. (Price Varies)',2500.00,5,'ava_pet.jpg'),
(15,'Flora & Fauna Stone Garden Markers','Set of three flat stones painted with local herbs and flowers, perfect for marking plants or decorating windowsills.',1900.00,12,'ava_markers.jpg'),
(15,'Painted Pebble Paperweight','A simple, elegant painted stone used to anchor papers, adding a touch of natural art to the workspace.',1100.00,18,'ava_weight.jpg'),

-- Shop 16: Xander's Modern Macrame
(16,'Rhythmic Form Wall Hanging','A large, complex macrame piece focusing on deep geometry and structure, translating musical rhythm into knots.',6800.00,5,'xander_wall.jpg'),
(16,'Geometry of Emotion Planter Hanger','A sturdy macrame plant hanger featuring complex knot patterns that rely on texture rather than color for impact.',2900.00,10,'xander_hanger.jpg'),
(16,'The Quiet Strength Room Divider','A large, semi-transparent macrame panel used to define space without fully blocking light. Focus on structure and form.',12000.00,2,'xander_divider.jpg'),
(16,'Sensory Texture Trivet Set','A set of three thick, durable knotted trivets for hot items. Designed to appeal to the sense of touch and pattern.',1500.00,15,'xander_trivet.jpg'),
(16,'Minimalist Knot Keychain','A small keychain demonstrating a single, complex knot pattern, representing focus and discipline.',750.00,20,'xander_key.jpg'),

-- Shop 17: Freya's Earthy Trinkets
(17,'Perfectly Imperfect Jewelry Dish','A small, organic jewelry dish featuring clear fingertip marks and a slightly uneven rim. Celebrates authenticity.',750.00,15,'freya_dish.jpg'),
(17,'Honest Form Hand-Shaped Soap Tray','A natural clay tray for bar soap, intentionally irregular and uncoated to embrace its earthy texture.',650.00,20,'freya_soap.jpg'),
(17,'The Authentic Bowl','A medium-sized decorative bowl with a heavy base and an intentionally asymmetrical shape, celebrating natural imperfection.',1800.00,10,'freya_bowl.jpg'),
(17,'Organic Clay Planter','A small, porous planter designed to mimic the raw, rough texture of earth, perfect for small succulents.',900.00,15,'freya_planter.jpg'),
(17,'Earthy Texture Candle Vessel','A simple, unglazed clay vessel for small candles, designed to be reused and touched.',1100.00,12,'freya_candle.jpg'),

-- Shop 18: Zen Paper Art
(18,'Folded Paper Wall Art Piece','A large, three-dimensional geometric art piece created from thousands of meticulously folded paper units.',7500.00,3,'zen_panel.jpg'),
(18,'Focused Patience Quilled Art','A small, detailed piece made entirely of tiny, rolled paper strips, requiring hours of intense concentration.',2900.00,6,'zen_quilled.jpg'),
(18,'Extraordinary Detail Paper Frame','A small photo frame decorated entirely with hundreds of precise, hand-rolled paper flowers and designs.',2200.00,8,'zen_frame.jpg'),
(18,'The Calming Grid Art Print','A limited edition print of a complex paper grid pattern, representing discipline and mental clarity.',1500.00,15,'zen_grid.jpg'),
(18,'Geometric Paper Sculpture','A small, freestanding paper sculpture made of interlocking, folded modules. A desk ornament for focus.',1800.00,10,'zen_sculpt.jpg'),

-- Shop 19: Elio's Light & Resin
(19,'Commission: Illuminated Memory Lamp','Bespoke large lamp where the client''s sentimental objects (e.g., flowers, keys) are embedded and lit from within. (Price Varies)',15000.00,1,'elio_lamp.jpg'),
(19,'Bespoke History Cube Nightlight','A small, personalized nightlight cube embedding small objects (like baby teeth or simple tokens) provided by the client.',5800.00,5,'elio_cube.jpg'),
(19,'The Personal Talisman Desk Light','A small resin table lamp embedding personalized text or a small, symbolic plant, illuminating a daily ritual.',7500.00,4,'elio_desk.jpg'),
(19,'Floral Keepsake Resin Pendant','A necklace pendant made by sealing the client''s own dried flowers (e.g., from a wedding bouquet) in resin.',3200.00,10,'elio_pendant.jpg'),
(19,'Glow of Memory Coaster Set','Set of four resin coasters where the client provides small, flat paper mementos (like ticket stubs) to be embedded.',4100.00,6,'elio_coaster.jpg'),

-- Shop 20: Mila Handmade Soaps
(20,'Mother''s Purity Coconut Milk Bar','A pure, unscented cold-process soap made with extra coconut milk, ideal for sensitive skin and babies.',350.00,50,'mila_coconut.jpg'),
(20,'Gentle Care Local Herb Soap Bar','A soap bar infused with locally sourced chamomile and oatmeal, providing soothing relief for allergic or irritated skin.',380.00,40,'mila_herb.jpg'),
(20,'Peace of Mind Calming Bath Soak','A blend of natural salts and pure lavender oil, designed by a mother to promote relaxation and calm before bedtime.',750.00,20,'mila_soak.jpg'),
(20,'Nourishing Shea Butter Lip Balm','A small tin of balm made with high-quality shea butter and a touch of local beeswax for intense moisture.',450.00,30,'mila_lip.jpg'),
(20,'Tropical Citrus Kitchen Bar','A large, dense soap bar with a strong citrus scent and exfoliating grit, designed to remove cooking odors and grime.',400.00,35,'mila_citrus.jpg');


COMMIT;

-------- 2NF --------

-- 1. USERS TABLE (2NF)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(150) NOT NULL DEFAULT 'dummy_hash',
    email VARCHAR(150) UNIQUE,
    is_admin BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'default_profile.jpg'
);

-- 2. ADDRESSES TABLE (2NF)
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A',
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000'
);

-- 3. SHOPS TABLE (2NF)
CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    shop_category VARCHAR(150),
    description TEXT,
    owner_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_shop_id INTEGER REFERENCES shops(shop_id) ON DELETE SET NULL
);

-- 4. ITEMS TABLE (2NF)
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    img_url VARCHAR(250),
    shop_id INTEGER NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE
);


COMMIT;





-------- 3NF --------

DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS cart_items CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS category CASCADE; 
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS shops CASCADE;
DROP TABLE IF EXISTS users CASCADE;


-- 1. USERS TABLE (3NF)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(150) NOT NULL DEFAULT 'dummy_hash',
    is_admin BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    gender VARCHAR(50),
    birthdate DATE,
    contact_num VARCHAR(20) NOT NULL DEFAULT 'N/A',
    bio TEXT,
    profile_img_url VARCHAR(250) DEFAULT 'default_profile.jpg'
);

-- 2. ADDRESSES TABLE (3NF)
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
    street_address VARCHAR(150) NOT NULL DEFAULT 'N/A',
    city VARCHAR(100) NOT NULL DEFAULT 'N/A', 
    province VARCHAR(100) NOT NULL DEFAULT 'N/A',
    zip_code VARCHAR(20) NOT NULL DEFAULT '0000'
);

-- 3.CATEGORY (3NF) ------- NEW TABLE THAT NORMALIZES ITEM TYPES
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300) UNIQUE NOT NULL,
    code VARCHAR(50)
);

-- 4. SHOPS TABLE (3NF)
CREATE TABLE shops (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    owner_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    parent_shop_id INTEGER REFERENCES shops(shop_id) ON DELETE SET NULL
);

-- 5. ITEMS TABLE (3NF)
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0,
    img_url VARCHAR(250),
    category_id INT NOT NULL REFERENCES category(id) ON DELETE CASCADE,
    shop_id INTEGER NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE
);

-- 6. CART_ITEMS TABLE (3NF)
CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT DEFAULT 1
);

-- 7. ORDERS TABLE (3NF)
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'placed',
    location VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. ORDER_ITEMS TABLE (3NF)
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(item_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price FLOAT NOT NULL
);

-- 9. RATINGS TABLE (3NF)
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    shop_id INT NOT NULL REFERENCES shops(shop_id) ON DELETE CASCADE,
    value INT NOT NULL,
    CONSTRAINT uq_user_shop_rating UNIQUE (user_id, shop_id)
);


-- 3NF DATA INSERTION

INSERT INTO users (username, password_hash, is_admin, first_name, last_name, gender, birthdate, contact_num, bio, profile_img_url) VALUES
('ZiaMadePH', 'dummy_hash', TRUE, 'Zia', 'Gonzales', 'Female', '1995-03-12', '09171234567', 'Kapampangan potter preserving centuries-old hand-building techniques.', 'zia.jpg'),
('AltheaCreates', 'dummy_hash', TRUE, 'Althea', 'Ramos', 'Female', '1992-08-21', '09172345678', 'Knitting as therapy — every stitch made with love and healing.', 'althea.jpg'),
('KaiGoods', 'dummy_hash', TRUE, 'Kai', 'Tan', 'Male', '1990-11-05', '09173456789', 'Zero-waste woodworker using reclaimed Philippine hardwood.', 'kai.jpg'),
('MaelysWeave', 'dummy_hash', TRUE, 'Maëlys', 'Santos', 'Female', '1998-04-19', '09174567890', '100+ hour embroidery artist — patience is my medium.', 'maelys.jpg'),
('EthanLeather', 'dummy_hash', TRUE, 'Ethan', 'Lopez', 'Male', '1993-01-25', '09175678901', 'Marikina leather heirlooms with lifetime repair guarantee.', 'ethan.jpg'),
('ZoeyAtbp', 'dummy_hash', TRUE, 'Zoey', 'Villanueva', 'Female', '2001-07-30', '09176789012', 'Preserving Philippine nature forever in resin jewelry.', 'zoey.jpg'),
('LiamPrint', 'dummy_hash', TRUE, 'Liam', 'De La Cruz', 'Male', '1996-10-01', '09177890123', 'Reviving the soul of antique letterpress printing.', 'liam.jpg'),
('LunaCrafted', 'dummy_hash', TRUE, 'Luna', 'Reyes', 'Female', '1997-12-14', '09178901234', 'I turn your birth sky into wearable celestial jewelry.', 'luna.jpg'),
('CieloScents', 'dummy_hash', TRUE, 'Cielo', 'Mendoza', 'Female', '1991-05-08', '09179012345', '100% natural Filipino scents in soy candles & soaps.', 'cielo.jpg'),
('NicoCeramics', 'dummy_hash', TRUE, 'Nico', 'Lim', 'Male', '1994-06-28', '09181234567', 'Wabi-sabi potter celebrating imperfection.', 'nico.jpg'),
('SkyeTextile', 'dummy_hash', TRUE, 'Skye', 'Garcia', 'Female', '1999-02-03', '09182345678', 'Upcycling vintage barong & Filipiniana into modern pieces.', 'skye.jpg'),
('AmariMetals', 'dummy_hash', TRUE, 'Amari', 'Dela Rosa', 'Female', '1990-09-17', '09183456789', 'Keeping Filipino filigree art alive, one twist at a time.', 'amari.jpg'),
('ChloeQuilts', 'dummy_hash', TRUE, 'Chloe', 'Aquino', 'Female', '1993-03-29', '09184567890', 'Memory quilts stitched from family clothes & stories.', 'chloe.jpg'),
('JaviBuilds', 'dummy_hash', TRUE, 'Javi', 'Torres', 'Male', '1997-07-07', '09185678901', 'Heirloom furniture built with zero shortcuts.', 'javi.jpg'),
('AvaPaints', 'dummy_hash', TRUE, 'Ava', 'Salazar', 'Female', '2000-04-11', '09186789012', 'Painting tiny worlds on river stones found underfoot.', 'ava.jpg'),
('XanderWares', 'dummy_hash', TRUE, 'Xander', 'Bautista', 'Male', '1995-08-04', '09187890123', 'Modern macramé translating emotion into geometric knots.', 'xander.jpg'),
('FreyaClay', 'dummy_hash', TRUE, 'Freya', 'Castro', 'Female', '1991-05-22', '09188901234', 'Raw, unglazed ceramics that show the honest human touch.', 'freya.jpg'),
('ZenCraftsMNL', 'dummy_hash', TRUE, 'Zen', 'Ramos', 'Male', '1998-09-10', '09189012345', '3D paper sculptures born from thousands of mindful folds.', 'zen.jpg'),
('ElioLighting', 'dummy_hash', TRUE, 'Elio', 'Fernandez', 'Male', '1994-12-03', '09191234567', 'Turning your memories into glowing resin lamps.', 'elio.jpg'),
('MilaKape', 'dummy_hash', TRUE, 'Mila', 'Corpuz', 'Female', '1992-06-16', '09192345678', 'Cold-process soaps made with pure local love.', 'mila.jpg');

--- ADDRESS DATA ---
INSERT INTO addresses (user_id, street_address, city, province, zip_code) VALUES
(1, '88 Duyan St., San Roque', 'San Fernando', 'Pampanga', '2000'),
(2, '12 Munting Lupa, Poblacion', 'Quezon City', 'Metro Manila', '1100'),
(3, 'Blk 5 Lot 14 Aklan Rd., Holy Spirit', 'Cebu City', 'Cebu', '6000'),
(4, '77 Makisig Ave., San Isidro', 'Makati', 'Metro Manila', '1200'),
(5, '22 Shoe Road, Concepcion Uno', 'Marikina', 'Metro Manila', '1800'),
(6, '9 Palawan Way, Sta. Monica', 'Puerto Princesa', 'Palawan', '5300'),
(7, '4 Antique Press Lane, Sampaloc', 'Manila', 'Metro Manila', '1008'),
(8, '16 Constellation Blvd., Kanan', 'Legazpi', 'Albay', '4500'),
(9, '33 Aromatics Circle, Purok 5', 'Naga City', 'Camarines Sur', '4400'),
(10, '10 Glaze Trail, Malinta', 'Valenzuela', 'Metro Manila', '1440'),
(11, '5 Barong Thread, San Jose', 'Baguio City', 'Benguet', '2600'),
(12, '1 Filigree St., Poblacion', 'Vigan', 'Ilocos Sur', '2700'),
(13, '18 Comfort Lane, Commonwealth', 'Quezon City', 'Metro Manila', '1121'),
(14, '6 Joinery Road, Sta. Cruz', 'Davao City', 'Davao del Sur', '8000'),
(15, '15 River Stone Path, San Agustin', 'Tagaytay City', 'Cavite', '4120'),
(16, '22 Knotting Loop, Talisay', 'Bacolod City', 'Negros Occidental', '6100'),
(17, '7 Earthy Hill, Polo', 'Iloilo City', 'Iloilo', '5000'),
(18, '99 Folding Point, Pinagbuhatan', 'Pasig', 'Metro Manila', '1600'),
(19, '3 Resin Light, Mambaling', 'Cebu City', 'Cebu', '6004'),
(20, '1 Coconut Oil Dr., Calamba', 'Lucena City', 'Quezon', '4301');

--- CATEGORY DATA
INSERT INTO category (name, code) VALUES
('Home & Functional Ceramics','CERAMIC'),        
('Sustainable Textiles & Fiber Art','TEXTILE'), 
('Leather & Wood Goods','WOOD'),                
('Personal Accessories & Jewelry','JEWELRY'),   
('Fine Art & Stationery','ART'),               
('Aromatics & Wellness','WELLNESS'),            
('Heirloom & Custom Gifts','GIFT');             

--- SHOP DATA
INSERT INTO shops (owner_id, name, description) VALUES
(1,'The Zia Clay Studio','Preserving the legacy of Pampanga in modern form. We fuse age-old Kapampangan hand-building techniques with contemporary design. Every piece carries the intentional mark of human hands, ensuring that our heritage and the warmth of tradition enrich your modern home. '),
(2,'Althea''s Knit & Knot','Knitting therapy into every stitch. Our throws and accessories are created with mindfulness, offering comfort and peace (Kapayapaan). Choosing our fiber art supports mothers who turn anxiety into beautiful, therapeutic, handcrafted textile works. '),
(3,'Kai''s Minimalist Wood','Sustainable elegance from salvaged history. We refuse waste, creating minimalist designs solely from reclaimed Philippine hardwoods. Our commitment is to honesty, integrity, and building heirloom pieces that respect the material and last a lifetime. '),
(4,'Maëlys Fabric & Thread','Where patience is the medium. We specialize in intricate embroidery, dedicating over a hundred hours to capturing the detail of local flora and fauna. Buy the passage of time—a tangible tribute to Filipino nature and slow, devotional craftsmanship.'),
(5,'Ethan''s Leather Works','Heirlooms built to defy fast fashion. Hand-stitched in Marikina using only honest, vegetable-tanned leather. We offer a lifetime repair guarantee because we believe true quality is a promise of enduring companionship, not disposable trends.'),
(6,'Zoey''s Resin Gems','Immortality for nature''s most delicate moments. I collect and preserve tiny elements of the Philippine wilderness—petals, moss, sand—in crystal-clear resin. Wear a micro-museum, a timeless piece of our islands'' fleeting beauty. '),
(7,'Liam Letterpress Studio','Reviving the luxurious, tactile art of communication. We use antique presses to create stationery with a deep, physical impression. Choose the deliberate, soulful elegance of letterpress over the flatness of digital speed.'),
(8,'Luna & Stars Jewelry','Jewelry as a personal celestial map. We hand-set precious stones to replicate your birth constellation or a significant moon phase. Our pieces are more than adornment; they are deeply personal talismans that track your unique cosmic history.'),
(9,'Cielo Aromatic Crafts','The authentic scent of the Philippines, bottled. We reject synthetics, using natural waxes and local oils to capture the real aromas of Sampaguita, sea air, and earth. Light a true olfactory journey back to your favorite Filipino memory.'),
(10,'Nico''s Wheel & Glaze','Embracing Wabi-Sabi: The beauty of the human touch. I hand-throw every ceramic piece, celebrating the slight wobble and unique glaze crackle that a machine would reject. Choose character and honest form over cold, factory perfection. '),
(11,'Skye and Stitch','Giving history a second life. We meticulously deconstruct and reassemble damaged Barongs and vintage textiles into modern accessories. Our craft is a beautiful stand against textile waste and a celebration of rebirth.'),
(12,'Amari Fine Filigree','Funding the survival of a national treasure. My jewelry uses centuries-old Filigree techniques, meticulously twisting metal threads by hand. You are investing in the survival of a beautiful, vanishing Filipino heritage craft. '),
(13,'Chloe''s Comfort Quilt','Stitching family memories into lasting comfort. Our quilts are designed as heavy, comforting heirlooms, combining fabric scraps that represent shared history. We offer a generational embrace, built to gather memories for decades. '),
(14,'Javi Custom Furniture','Heirloom quality built with necessary patience. I refuse to compromise on the time required for perfection. We hand-sand and join every piece to create resilient, soulful furniture—a quiet stand against disposable consumerism. '),
(15,'Ava’s Painted Stones','Finding art in the unexpected, natural canvas. I use perfectly shaped river stones as my medium for detailed miniature landscapes. My work reminds you that profound beauty can be found anywhere, even in a simple rock underfoot. '),
(16,'Xander''s Modern Macrame','Translating rhythm and feeling into geometric form. I specialize in complex macrame patterns, creating texture and structure that appeal to all the senses. Experience the quiet strength and sophistication of the knotted human hand. '),
(17,'Freya''s Earthy Trinkets','Honest forms, perfectly imperfect. Using natural clay, my pieces bear the clear, unpolished marks of my fingertips. I invite you to embrace the authenticity and slight irregularity that makes handmade items feel truly warm and personal. '),
(18,'Zen Paper Art','Where focused patience meets extraordinary detail. My complex 3D art is created by meticulously folding thousands of paper strips. Choose this art as a visual journey toward mindfulness and appreciation for astonishing, dedicated craft. '),
(19,'Elio''s Light & Resin','Illuminating your personal history. I create bespoke lamps by embedding your most sentimental mementos (keys, flowers, trinkets) in clear resin. Turn your most cherished memories into the brightest, most beautiful source of light in your home.'),
(20,'Mila Handmade Soaps','Mother''s love and purity in every bar. My cold-process soaps grew from a necessity to provide safe, natural care for my family. We use pure, local ingredients to offer you relief, nourishing care, and absolute peace of mind.');

--- ITEMS DATA 
INSERT INTO items (shop_id,category_id,name,description,price,stock,img_url) VALUES
-- Shop 1: The Zia Clay Studio (CERAMIC)
(1,1,'Lola''s Legacy Coffee Mug','Hand-coiled mug using Kapampangan technique, finished in a smooth, modern white glaze. Perfectly weighted for comfort.',850.00,10,'zia_mug.jpg'),
(1,1,'Pampanga Sunrise Pinch Bowl Set','Set of three small, earthy bowls, ideal for condiments or spices. Features exposed terracotta clay along the base.',1200.00,5,'zia_pinch.jpg'),
(1,1,'Heritage Coil-Built Vase','Tall, structural vase built entirely by hand-coiling. A statement piece that bridges ancient craft and modern interior design.',4500.00,3,'zia_vase.jpg'),
(1,1,'The Zia Signature Dinner Plate','Large, flat plate with a subtle, intentional irregularity in the rim, glazed in deep, matte forest green.',1500.00,8,'zia_plate.jpg'),
(1,1,'Earth''s Embrace Incense Holder','A small, organic piece designed to hold burning incense. Its form is inspired by the curvature of the clay as it dries.',650.00,12,'zia_incense.jpg'),

-- Shop 2: Althea''s Knit & Knot (TEXTILE)
(2,2,'Kapayapaan Weighted Throw','A large, densely knit throw blanket designed for comfort and anxiety relief. Crafted with therapeutic, repetitive stitches.',7800.00,4,'althea_throw.jpg'),
(2,2,'Hinga Meditation Mat','A circular, crocheted mat made from recycled cotton rope, offering a soft, textured space for breathing and mindfulness.',3200.00,6,'althea_mat.jpg'),
(2,2,'Resilience Texture Pillow Cover','A decorative cushion cover with intricate, complex cable-knit patterns, symbolizing strength and recovery.',1800.00,15,'althea_pillow.jpg'),
(2,2,'Therapy Yarn Keychain Set','Small, woven keychains made from yarn scraps. A pocket-sized reminder to pause and breathe throughout the day.',750.00,20,'althea_key.jpg'),
(2,2,'Moms'' Collaborative Shawl','A lightweight shawl featuring panels knit by three different mothers, symbolizing community and shared purpose.',4500.00,7,'althea_shawl.jpg'),

-- Shop 3: Kai''s Minimalist Wood (WOOD)
(3,3,'The Architect''s Desk Organizer','Minimalist organizer made from reclaimed Narra wood. Features clean lines and multiple slots for essentials.',2900.00,9,'kai_org.jpg'),
(3,3,'Honest Scrap Coaster Set','Set of four coasters made entirely from wood offcuts and construction waste. Each coaster’s grain tells a unique, salvaged story.',1100.00,18,'kai_coaster.jpg'),
(3,3,'Enduring Elegance Cutting Board','Solid block cutting board made from a single piece of reclaimed Philippine hardwood, built to last generations.',3500.00,6,'kai_board.jpg'),
(3,3,'Recycled Timber Catchall Tray','A simple, wide, low-profile tray for keys, phones, or wallets. Its beauty is in its respect for the original material.',2100.00,11,'kai_tray.jpg'),
(3,3,'Zero-Waste Planter Stand','Small, sturdy platform made from construction scrap, designed to elevate a ceramic planter or display object.',1600.00,14,'kai_stand.jpg'),

-- Shop 4: Maëlys Fabric & Thread (TEXTILE)
(4,2,'100-Hour Waling-Waling Art','Intricate, museum-quality embroidery capturing the vibrant life of the Philippine orchid. Certificate guarantees 100+ working hours.',9500.00,2,'maelys_orchid.jpg'),
(4,2,'Patient Stitch Bird Brooch','A tiny, highly detailed, hand-stitched brooch featuring a native Philippine bird. A wearable testament to dedication.',1900.00,10,'maelys_bird.jpg'),
(4,2,'Fauna Tapestry Wall Hanging','A medium-sized textile piece depicting a lush forest scene, created using hundreds of thousands of individual stitches.',14000.00,1,'maelys_tapestry.jpg'),
(4,2,'The Devotional Bookmark','A thin fabric bookmark featuring a miniature, precise floral embroidery. For slow readers who appreciate slow craft.',650.00,25,'maelys_bookmark.jpg'),
(4,2,'Monochrome Insect Study','A small, black and white embroidery piece studying the geometry of a local insect. Focus on line and form.',3800.00,5,'maelys_insect.jpg'),

-- Shop 5: Ethan''s Leather Works (WOOD)
(5,3,'Marikina Heirloom Bifold Wallet','Hand saddle-stitched wallet made from vegetable-tanned cowhide. Designed to last decades, guaranteed for life.',3400.00,12,'ethan_wallet.jpg'),
(5,3,'The Traveler''s Sentinel Pouch','A rugged, compact zippered pouch ideal for cables, passports, or small tools. Ages beautifully with use.',4100.00,8,'ethan_pouch.jpg'),
(5,3,'Legacy Full-Grain Belt','A simple, durable leather belt cut from a single, high-quality hide, finished with a solid brass buckle.',3800.00,10,'ethan_belt.jpg'),
(5,3,'Desk Mat of Durability','A large, thick leather mat for the desktop, providing a smooth workspace and protecting the desk underneath.',6200.00,5,'ethan_deskmat.jpg'),
(5,3,'Personalized Cable Keeper Set','Set of three small leather snaps to manage wires and cables. Monogramming available to personalize your gear.',1050.00,20,'ethan_cable.jpg'),

-- Shop 6: Zoey''s Resin Gems (JEWELRY)
(6,4,'Immortality Petal Pendant','A single, vibrant petal from a Philippine orchid, perfectly suspended in a clear, round resin necklace.',2200.00,15,'zoey_pendant.jpg'),
(6,4,'Palawan Sand Micro-Landscape Ring','A ring featuring tiny layers of sand, moss, and shells, creating a miniature world sealed within the resin dome.',1950.00,10,'zoey_ring.jpg'),
(6,4,'Ephemeral Beauty Stud Earrings','Tiny stud earrings featuring preserved moss and gold leaf, capturing the fleeting greenness of the wilderness.',1400.00,25,'zoey_studs.jpg'),
(6,4,'Botanical Micro-Museum Coasters','Set of four clear resin coasters embedded with dried ferns and flowers. Protects surfaces with preserved nature.',3800.00,6,'zoey_coasters.jpg'),
(6,4,'Oceanic Flow Hair Pin','A long hair pin with blue-tinted resin embedded with seafoam and beach-combed elements.',1650.00,10,'zoey_hairpin.jpg'),

-- Shop 7: Liam Letterpress Studio (ART)
(7,5,'The Tactile Thank You Card Set','A set of 10 thank you cards printed on thick cotton paper, featuring a deep, satisfying impression that you can feel.',1800.00,30,'liam_cards.jpg'),
(7,5,'“Slower is Soulful” Art Print','A small, black and white quote print affirming the value of slow craft, perfect for a studio wall.',1500.00,15,'liam_print.jpg'),
(7,5,'Hand-Fed Custom Stationery','Personalized letterhead and envelopes, individually hand-fed through the antique press for unmatched quality.',4500.00,5,'liam_stationery.jpg'),
(7,5,'The Legacy Coaster Set','Set of four thick-stock coasters featuring classic Filipino script and deep debossing.',1100.00,20,'liam_coaster.jpg'),
(7,5,'Vintage Manila Map Print','A historical map of Manila printed using a two-color letterpress technique on textured archival paper.',2800.00,10,'liam_map.jpg'),

-- Shop 8: Luna & Stars Jewelry (JEWELRY)
(8,4,'Custom Birth Constellation Necklace','A pendant featuring hand-set cubic zirconia stones arranged precisely to mirror the wearer''s birth star pattern.',3900.00,8,'luna_const.jpg'),
(8,4,'Solstice Moon Phase Ring','A sterling silver ring engraved with the exact moon phase from a significant date (wedding, graduation, etc.).',3200.00,10,'luna_moon.jpg'),
(8,4,'Celestial Map Studs','Simple, geometric studs representing the major stars in the Philippine sky, designed to be worn daily as a talisman.',2100.00,18,'luna_studs.jpg'),
(8,4,'Andromeda Stacking Bracelet','A delicate silver chain bracelet with tiny, spaced celestial charms inspired by the Andromeda galaxy.',2500.00,15,'luna_bracelet.jpg'),
(8,4,'Cosmic Connection Locket','A locket with a high-polish finish, designed to hold a small photo and engraved with the wearer''s zodiac sign.',4800.00,7,'luna_locket.jpg'),

-- Shop 9: Cielo Aromatic Crafts (WELLNESS)
(9,6,'Sampaguita Dawn Soy Candle','Natural soy wax candle with a pure essential oil blend that perfectly captures the complex, intoxicating scent of the morning air.',1400.00,20,'cielo_candle.jpg'),
(9,6,'Bicol Sea Salt Air Reed Diffuser','A non-toxic, slow-release diffuser using local oils to bring the crisp, clean scent of the Bicol coast into your home.',1800.00,15,'cielo_diffuser.jpg'),
(9,6,'Post-Rain Earth Musk Wax Melts','Small wax melts that evoke the deep, comforting, earthy smell of petrichor (rain on dry ground) and tropical musk.',850.00,30,'cielo_melts.jpg'),
(9,6,'Gumamela & Honey Hand Balm','A rich, natural hand balm made with local beeswax and a hint of sweet Gumamela floral essence.',950.00,25,'cielo_balm.jpg'),
(9,6,'Aromatherapy Travel Tin Set','Set of three small, portable candles: Dawn, Noon, and Dusk, each with a distinct Philippine scent profile.',2500.00,10,'cielo_travel.jpg'),

-- Shop 10: Nico''s Wheel & Glaze (CERAMIC)
(10,1,'Wabi-Sabi Daily Coffee Mug','Hand-thrown mug with a deliberate, natural wobble and a unique crackle glaze. No two are exactly alike.',950.00,10,'nico_mug.jpg'),
(10,1,'Honest Form Serving Platter','A wide, low serving platter with an intentionally asymmetrical shape, showcasing the clear marks of the throwing process.',3600.00,5,'nico_platter.jpg'),
(10,1,'Proof of Hand Dinner Bowl Set','Set of two rustic, durable bowls designed for daily use. Their imperfection is proof of their soulful creation.',1800.00,8,'nico_bowls.jpg'),
(10,1,'Artisan''s Thumbprint Sake Cups','A set of four tiny cups featuring the clear indentations of Nico''s thumb where the cup was pinched during throwing.',1400.00,12,'nico_sake.jpg'),
(10,1,'Glaze Study Decorative Tile','A small, square tile used to test a new homemade glaze. A collector''s piece celebrating the unpredictability of fire.',1200.00,6,'nico_tile.jpg'),

-- Shop 11: Skye and Stitch (TEXTILE)
(11,2,'Reborn Barong Tagalog Clutch','A stylish clutch bag crafted from disassembled vintage Barong fabrics. Each piece carries a unique slice of history.',2600.00,10,'skye_clutch.jpg'),
(11,2,'Filipiniana Scrap Patchwork Pouch','A small zippered pouch made from a colorful, curated mosaic of old Filipiniana dress scraps.',1500.00,15,'skye_pouch.jpg'),
(11,2,'The Second Life Upcycled Scarf','A long scarf created by carefully piecing together undamaged sections of discarded luxury fabrics and silk.',3100.00,7,'skye_scarf.jpg'),
(11,2,'Textile History Wall Banner','A decorative hanging banner featuring layered, stitched sections of various Filipino textile remnants.',4200.00,4,'skye_banner.jpg'),
(11,2,'Zero-Waste Cord Wraps','Set of small fabric wraps made from the smallest fabric scraps. Perfect for keeping earphones and cords tidy.',800.00,30,'skye_wraps.jpg'),

-- Shop 12: Amari Fine Filigree (JEWELRY)
(12,4,'Ancestral Filigree Drop Earrings','Delicate sterling silver drop earrings featuring the intricate, lacelike metalwork of traditional Filipino Filigree.',5500.00,8,'amari_earrings.jpg'),
(12,4,'Survival of the Craft Ring','A substantial ring featuring a central filigree dome, symbolizing the dedication required to keep this beautiful craft alive.',4800.00,6,'amari_ring.jpg'),
(12,4,'Heirloom-Quality Filigree Brooch','A statement brooch crafted entirely from fine, hand-twisted silver wire. An elegant piece of history.',6200.00,5,'amari_brooch.jpg'),
(12,4,'The Ilocos Bloom Pendant','A small, floral pendant designed using traditional Filigree techniques learned from Ilocano masters.',3500.00,10,'amari_pendant.jpg'),
(12,4,'Metal Thread Dainty Bracelet','A delicate, thin bracelet made of fine silver thread, perfect for stacking and celebrating the precision of the craft.',2900.00,15,'amari_bracelet.jpg'),

-- Shop 13: Chloe''s Comfort Quilt (GIFT)
(13,7,'The Generational Memory Quilt','Large, custom-commissioned quilt made from your loved ones'' significant fabric scraps and old clothing. (Price Varies)',18000.00,1,'chloe_memory.jpg'),
(13,7,'Heavy Comfort Lap Throw','A smaller, weighted quilt designed to provide a sense of security and a comforting embrace while reading or resting.',8500.00,5,'chloe_lap.jpg'),
(13,7,'Family History Stitched Pillow','A large, decorative pillow made from patchwork blocks, ideal for displaying and cherishing small fabric memories.',3500.00,8,'chloe_pillow.jpg'),
(13,7,'The Endurance Baby Quilt','A small, durable quilt made from high-quality cottons, designed to be washed, loved, and passed down through generations.',4900.00,6,'chloe_baby.jpg'),
(13,7,'Patchwork Table Runner','A colorful, narrow runner made from carefully selected fabric remnants, adding warmth and history to your dining table.',2800.00,10,'chloe_runner.jpg'),

-- Shop 14: Javi Custom Furniture (WOOD)
(14,3,'The Patient-Crafted Console Table','Slim entry table made from Philippine hardwood, featuring impeccable joinery and a luxurious, hand-oiled finish.',16000.00,2,'javi_console.jpg'),
(14,3,'Legacy Wood Hand-Sanded Stool','A sturdy, compact stool built to last a century. The smooth finish is the result of hours of hand-sanding.',7500.00,5,'javi_stool.jpg'),
(14,3,'Anti-Disposable Investment Shelf','A minimalist floating shelf designed with traditional, durable joinery. Requires weeks of intentional creation.',9800.00,3,'javi_shelf.jpg'),
(14,3,'The Heirloom Cutting Board','An extra-thick, heavy-duty cutting board designed for professional use, meant to gather character and last forever.',4500.00,7,'javi_board.jpg'),
(14,3,'Woodworker''s Signature Pen Holder','A small, elegant desk accessory showcasing a flawless, hand-oiled finish on a block of Philippine mahogany.',2100.00,10,'javi_pen.jpg'),

-- Shop 15: Ava’s Painted Stones (ART)
(15,5,'River Stone Miniature Landscape','A smooth, natural river stone painted with a detailed, miniature scene of a Filipino rice terrace or beach.',1500.00,15,'ava_landscape.jpg'),
(15,5,'Found Beauty Hand-Painted Wildlife Rock','A naturally-shaped stone featuring a lifelike painting of a Philippine Eagle or local butterfly.',1800.00,10,'ava_eagle.jpg'),
(15,5,'Underfoot Canvas Custom Pet Portrait','Commission a detailed miniature portrait of a beloved pet, painted on a smooth, naturally-formed stone. (Price Varies)',2500.00,5,'ava_pet.jpg'),
(15,5,'Flora & Fauna Stone Garden Markers','Set of three flat stones painted with local herbs and flowers, perfect for marking plants or decorating windowsills.',1900.00,12,'ava_markers.jpg'),
(15,5,'Painted Pebble Paperweight','A simple, elegant painted stone used to anchor papers, adding a touch of natural art to the workspace.',1100.00,18,'ava_weight.jpg'),

-- Shop 16: Xander''s Modern Macrame (TEXTILE)
(16,2,'Rhythmic Form Wall Hanging','A large, complex macrame piece focusing on deep geometry and structure, translating musical rhythm into knots.',6800.00,5,'xander_wall.jpg'),
(16,2,'Geometry of Emotion Planter Hanger','A sturdy macrame plant hanger featuring complex knot patterns that rely on texture rather than color for impact.',2900.00,10,'xander_hanger.jpg'),
(16,2,'The Quiet Strength Room Divider','A large, semi-transparent macrame panel used to define space without fully blocking light. Focus on structure and form.',12000.00,2,'xander_divider.jpg'),
(16,2,'Sensory Texture Trivet Set','A set of three thick, durable knotted trivets for hot items. Designed to appeal to the sense of touch and pattern.',1500.00,15,'xander_trivet.jpg'),
(16,2,'Minimalist Knot Keychain','A small keychain demonstrating a single, complex knot pattern, representing focus and discipline.',750.00,20,'xander_key.jpg'),

-- Shop 17: Freya''s Earthy Trinkets (CERAMIC)
(17,1,'Perfectly Imperfect Jewelry Dish','A small, organic jewelry dish featuring clear fingertip marks and a slightly uneven rim. Celebrates authenticity.',750.00,15,'freya_dish.jpg'),
(17,1,'Honest Form Hand-Shaped Soap Tray','A natural clay tray for bar soap, intentionally irregular and uncoated to embrace its earthy texture.',650.00,20,'freya_soap.jpg'),
(17,1,'The Authentic Bowl','A medium-sized decorative bowl with a heavy base and an intentionally asymmetrical shape, celebrating natural imperfection.',1800.00,10,'freya_bowl.jpg'),
(17,1,'Organic Clay Planter','A small, porous planter designed to mimic the raw, rough texture of earth, perfect for small succulents.',900.00,15,'freya_planter.jpg'),
(17,1,'Earthy Texture Candle Vessel','A simple, unglazed clay vessel for small candles, designed to be reused and touched.',1100.00,12,'freya_candle.jpg'),

-- Shop 18: Zen Paper Art (ART)
(18,5,'Folded Paper Wall Art Piece','A large, three-dimensional geometric art piece created from thousands of meticulously folded paper units.',7500.00,3,'zen_panel.jpg'),
(18,5,'Focused Patience Quilled Art','A small, detailed piece made entirely of tiny, rolled paper strips, requiring hours of intense concentration.',2900.00,6,'zen_quilled.jpg'),
(18,5,'Extraordinary Detail Paper Frame','A small photo frame decorated entirely with hundreds of precise, hand-rolled paper flowers and designs.',2200.00,8,'zen_frame.jpg'),
(18,5,'The Calming Grid Art Print','A limited edition print of a complex paper grid pattern, representing discipline and mental clarity.',1500.00,15,'zen_grid.jpg'),
(18,5,'Geometric Paper Sculpture','A small, freestanding paper sculpture made of interlocking, folded modules. A desk ornament for focus.',1800.00,10,'zen_sculpt.jpg'),

-- Shop 19: Elio''s Light & Resin (GIFT)
(19,7,'Commission: Illuminated Memory Lamp','Bespoke large lamp where the client''s sentimental objects (e.g., flowers, keys) are embedded and lit from within. (Price Varies)',15000.00,1,'elio_lamp.jpg'),
(19,7,'Bespoke History Cube Nightlight','A small, personalized nightlight cube embedding small objects (like baby teeth or simple tokens) provided by the client.',5800.00,5,'elio_cube.jpg'),
(19,7,'The Personal Talisman Desk Light','A small resin table lamp embedding personalized text or a small, symbolic plant, illuminating a daily ritual.',7500.00,4,'elio_desk.jpg'),
(19,7,'Floral Keepsake Resin Pendant','A necklace pendant made by sealing the client''s own dried flowers (e.g., from a wedding bouquet) in resin.',3200.00,10,'elio_pendant.jpg'),
(19,7,'Glow of Memory Coaster Set','Set of four resin coasters where the client provides small, flat paper mementos (like ticket stubs) to be embedded.',4100.00,6,'elio_coaster.jpg'),

-- Shop 20: Mila Handmade Soaps (WELLNESS)
(20,6,'Mother''s Purity Coconut Milk Bar','A pure, unscented cold-process soap made with extra coconut milk, ideal for sensitive skin and babies.',350.00,50,'mila_coconut.jpg'),
(20,6,'Gentle Care Local Herb Soap Bar','A soap bar infused with locally sourced chamomile and oatmeal, providing soothing relief for allergic or irritated skin.',380.00,40,'mila_herb.jpg'),
(20,6,'Peace of Mind Calming Bath Soak','A blend of natural salts and pure lavender oil, designed by a mother to promote relaxation and calm before bedtime.',750.00,20,'mila_soak.jpg'),
(20,6,'Nourishing Shea Butter Lip Balm','A small tin of balm made with high-quality shea butter and a touch of local beeswax for intense moisture.',450.00,30,'mila_lip.jpg'),
(20,6,'Tropical Citrus Kitchen Bar','A large, dense soap bar with a strong citrus scent and exfoliating grit, designed to remove cooking odors and grime.',400.00,35,'mila_citrus.jpg');

COMMIT;