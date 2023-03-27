resource "google_container_registry" "registry" {
  project  = var.project_id
  location = var.location
}

resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  database_version = "MYSQL_8_0"
  region           = var.region
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name      = var.app_name
  instance  = google_sql_database_instance.instance.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.instance.name
  host     = "%"
  password = "mypassw0rd"
}