CREATE TABLE "combat_logs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "file_file_name" varchar(255), "file_content_type" varchar(255), "file_file_size" integer, "file_updated_at" datetime);
CREATE TABLE "encounters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "combat_log_id" integer, "start_time" datetime, "end_time" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "owner_id" integer);
CREATE TABLE "entities" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "total_damage" integer, "player" boolean, "total_healing" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "encounter_id" integer, "max_damage" varchar(255), "max_healing" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120325220927');

INSERT INTO schema_migrations (version) VALUES ('20120326023959');

INSERT INTO schema_migrations (version) VALUES ('20120326025815');

INSERT INTO schema_migrations (version) VALUES ('20120326063036');

INSERT INTO schema_migrations (version) VALUES ('20120326070606');

INSERT INTO schema_migrations (version) VALUES ('20120327063533');

INSERT INTO schema_migrations (version) VALUES ('20120327064401');

INSERT INTO schema_migrations (version) VALUES ('20120327070235');

INSERT INTO schema_migrations (version) VALUES ('20120328041920');

INSERT INTO schema_migrations (version) VALUES ('20120328042011');

INSERT INTO schema_migrations (version) VALUES ('20120330145614');