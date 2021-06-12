ALTER TABLE orders
    ADD COLUMN auth_id text NOT NULL,
    DROP COLUMN order_no;

ALTER TABLE orders
    ADD COLUMN order_no BIGINT NOT NULL;
