# set your db, server, port, user and password, this example assumes you have set your environment variables to the requried values.
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = Sys.getenv("dbms"),
																																server = Sys.getenv("server"),
																																port = as.numeric(Sys.getenv("port")),
																																user = Sys.getEnv("username"),
																																password = Sys.getEnv("password")
																																)

# init tables

EndometriosisCharacterization::init(connectionDetails = connectionDetails, "{StudySchema}", tablePrefix = "endo_")

EndometriosisCharacterization::execute(connectionDetails = connectionDetails,
																			 createCohorts = TRUE,
																			 cdmDatabaseSchema = "{CDMSchema}",
																			 targetDatabaseSchema = "{StudySchema}",
																			 tablePrefix = "endo_",
																			 outputFolder = "{Path To Results Folder}")
