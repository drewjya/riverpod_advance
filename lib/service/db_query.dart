class CustomersQuery {
  static String tableName = "customers";
  static String createTable = """CREATE TABLE "$tableName" (
	"customerId"	INTEGER NOT NULL,
	"customerName"	TEXT NOT NULL DEFAULT "",
	"customersNum"	TEXT NOT NULL DEFAULT "",
	"dob"	TEXT NOT NULL DEFAULT "",
	"model"	TEXT NOT NULL DEFAULT "",
	"merk"	TEXT NOT NULL DEFAULT "",
	"picture"	TEXT,
	"createdBy"	INTEGER NOT NULL,
	PRIMARY KEY("customerId" AUTOINCREMENT),
	FOREIGN KEY("createdBy") REFERENCES "users"("id")
)""";
}

class UsersQuery {
  static String tableName = "users";
  static String createTable = """CREATE TABLE "$tableName" (
	"username"	TEXT NOT NULL,
	"password"	TEXT NOT NULL,
	"id"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
)""";
}
