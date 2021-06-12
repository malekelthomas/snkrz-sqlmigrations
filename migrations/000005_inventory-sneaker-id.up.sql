ALTER TABLE sneaker_inventory
    ADD COLUMN sneaker_id int NOT NULL;

ALTER TABLE sneaker_inventory
    ADD CONSTRAINT sneaker_inventory_sneaker_id_fkey
    FOREIGN KEY (sneaker_id)
    REFERENCES sneakers(id);