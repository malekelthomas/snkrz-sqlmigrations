ALTER TABLE orders
    DROP COLUMN auth_id,
    DROP COLUMN order_no;

ALTER TABLE orders
    ADD COLUMN order_no text NOT NULL;