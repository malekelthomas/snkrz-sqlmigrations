ALTER TABLE orders
    RENAME COLUMN carrier_shipping_method_id TO shipping_method_id;

ALTER TABLE orders
    DROP CONSTRAINT orders_carrier_shipping_method_id_fkey;

ALTER TABLE orders
    ADD CONSTRAINT orders_shipping_method_id_fkey
    FOREIGN KEY (shipping_method_id)
    REFERENCES shipping_methods(id);