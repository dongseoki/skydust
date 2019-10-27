import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DroneValuesDao {
	
	private static String dburl = "jdbc:mysql://localhost:3306/finedustdb";
	private static String dbUser = "skydustuser";
	private static String dbpasswd = "skydust123!@#";
	
	public DroneValues getDroneValue(String date) {
        
		DroneValues DroneValues = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
			String sql = "select  AVG(pm2), AVG(pm10) from finedust where keycode like '"+date+"%';";
			System.out.println(sql);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				float pm2 = rs.getFloat("avg(pm2)");
				float pm10 = rs.getFloat("avg(pm10)");
				DroneValues = new DroneValues(date, 1, pm2,pm10);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return DroneValues;
	}
}
