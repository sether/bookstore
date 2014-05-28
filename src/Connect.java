// File:	Connect.java
// Purpose:	Obtain a connection to an ODBC data source
// Listing:	Chapter 21, Listing 21.5
import java.sql.*;

public class Connect {
	static Connection conn;

	static Connection openDatabase(String url) {
	
	
	
	//	String urlBooks = "jdbc:mysql://localhost:3306/bookstore";
		String urlBooks = "jdbc:mysql://$OPENSHIFT_MYSQL_DB_HOST:$OPENSHIFT_MYSQL_DB_PORT/";


		try {
			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			//conn = DriverManager.getConnection (bookstore, "root", "");
			conn = DriverManager.getConnection (jbossews, "admingPE6WLK", "raCfHeIPbWii");
		}
		catch(Exception ex) {
			System.err.println(ex.getMessage());
			conn = null;
		}
		return conn;
	}

	static void isDatabaseUpdatable() {	// Get concurrency level
		try {
			DatabaseMetaData dbMetaData = conn.getMetaData();
			if (dbMetaData.supportsResultSetConcurrency(
				  ResultSet.TYPE_SCROLL_SENSITIVE,
				  ResultSet.CONCUR_UPDATABLE))
				System.err.println("Concurrency supported");
			else
				System.err.println("Concurrency not supported");
		}
		catch(Exception ex) {
			System.err.println(ex.getMessage());
		}
	}
			
}