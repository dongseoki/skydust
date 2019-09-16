
public class JDBEtest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		DroneValuesDao dao = new DroneValuesDao();
		DroneValues dronevalues = dao.getDroneValue("17");
		System.out.println(dronevalues);

	}

}
