CREATE TABLE IF NOT EXISTS "Counter" (
    "Count" INTEGER DEFAULT 0
);

INSERT INTO "Counter" ("Count") VALUES (0)
ON CONFLICT DO NOTHING;
