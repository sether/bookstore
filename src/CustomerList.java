// File:	CustomerList.java
// Purpose:	List the customers from Customer table; DBMS: mysql; database: Bookstore 
// Listing:	Chapter 21, Listing 21.2
import java.sql.*;

public class CustomerList {

	public static void main(String args[]) throws ClassNotFoundException {
		Connection conn;
		Statement statement;

		//String url = "jdbc:mysql://localhost:3306/bookstore";
		String url = "jdbc:mysql://$OPENSHIFT_MYSQL_DB_HOST:$OPENSHIFT_MYSQL_DB_PORT/";
	
		try {
			//Class.forName("com.mysql.jdbc.Driver"); // Load MySQL driver

			//conn = DriverManager.getConnection (url, "root", "");
			conn = DriverManager.getConnection (url, "admingPE6WLK", "raCfHeIPbWii");

			statement = conn.createStatement();

			// List the customers
			ResultSet rs = statement.executeQuery("SELECT * FROM customers");
			System.out.println("Cust.Id         LastName");
			while (rs.next()) {
				String lastName = rs.getString("LastName");
				int custId = rs.getInt("CustId");
				System.out.println(custId + "\t\t" + lastName);
			}
			statement.close();
			conn.close();
		}
		catch(Exception ex) {
			System.err.println("Exception: " + ex.getMessage());
		}
	}
}
