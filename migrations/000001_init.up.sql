CREATE TABLE brands (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

INSERT INTO
    brands (name)
VALUES
    ('nike'),
    ('adidas'),
    ('jordan');

CREATE TABLE sites (
    id serial PRIMARY KEY,
    name text NOT NULL
);

INSERT INTO
    sites (name)
VALUES
    ('STADIUMGOODS');

CREATE TABLE sneakers (
    id serial PRIMARY KEY,
    brand_id int NOT NULL,
    model_name text UNIQUE,
    release_date timestamptz,
    photos text [],
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE sneaker_inventory (
    id serial PRIMARY KEY,
    sku text NOT NULL,
    quantity int DEFAULT 0,
    model_name text
);

CREATE TABLE site_size_price (
    id serial PRIMARY KEY,
    site_id int NOT NULL,
    sneaker_id int NOT NULL,
    size text NOT NULL,
    price int NOT NULL,
    inventory_id int NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES sneaker_inventory(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (site_id) REFERENCES sites(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sneaker_id) REFERENCES sneakers(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE user_roles (
    id serial PRIMARY KEY,
    user_role text UNIQUE
);

INSERT INTO
    user_roles (user_role)
VALUES
    ('customer'),
    ('employee'),
    ('admin');

CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    user_role_id int NOT NULL,
    FOREIGN KEY (user_role_id) REFERENCES user_roles(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE tax_rates (
    id serial PRIMARY KEY,
    state text NOT NULL,
    tax_rate int NOT NULL
);

INSERT INTO
    tax_rates (state, tax_rate)
VALUES
    ('NY', 9);

CREATE TABLE carriers (
    id serial PRIMARY KEY,
    name text NOT NULL,
    icon_url text
);

INSERT INTO
    carriers (name)
VALUES
    ('fedex'),
    ('ups'),
    ('usps');

CREATE TABLE shipping_methods (
    id serial PRIMARY KEY,
    name text NOT NULL
);

INSERT INTO
    shipping_methods(name)
VALUES
    ('next-day'),
    ('two-day'),
    ('three-day');

CREATE TABLE carrier_shipping_methods (
    id serial PRIMARY KEY,
    carrier_id int NOT NULL,
    shipping_method_id int NOT NULL,
    cost int NOT NULL,
    FOREIGN KEY (carrier_id) REFERENCES carriers(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_methods(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO
    carrier_shipping_methods (carrier_id, shipping_method_id, cost)
VALUES
    (1, 1, '2000'),
    (1, 2, '1700'),
    (1, 3, '1400'),
    (2, 1, '1700'),
    (2, 2, '1500'),
    (2, 3, '1200'),
    (3, 1, '2000'),
    (3, 2, '1800'),
    (3, 3, '1600');

CREATE TABLE orders (
    id serial PRIMARY KEY,
    order_no text NOT NULL,
    user_id int NOT NULL,
    subtotal int NOT NULL,
    tax_rate_id int NOT NULL,
    shipping_method_id int NOT NULL,
    total int NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tax_rate_id) REFERENCES tax_rates(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_methods(id) ON UPDATE CASCADE ON DELETE RESTRICT --didn't get added
);

CREATE TABLE order_items (
    id serial PRIMARY KEY,
    order_id int NOT NULL,
    sneaker_id int NOT NULL,
    sneaker_inventory_id int NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (sneaker_id) REFERENCES sneakers(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (sneaker_inventory_id) REFERENCES sneaker_inventory(id) ON UPDATE CASCADE ON DELETE RESTRICT
);