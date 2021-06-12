ALTER TABLE orders
    RENAME COLUMN shipping_method_id TO carrier_shipping_method_id;

ALTER TABLE orders
    DROP CONSTRAINT orders_shipping_method_id_fkey;

ALTER TABLE orders
    ADD CONSTRAINT orders_carrier_shipping_method_id_fkey
    FOREIGN KEY (carrier_shipping_method_id)
    REFERENCES carrier_shipping_methods(id);
    