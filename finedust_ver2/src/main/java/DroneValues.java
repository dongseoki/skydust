
public class DroneValues {
	private String  keycode;
	private int dronenum;
	private float pm2;
	private float pm10;
	
	public DroneValues(){
		
	}
	
	public DroneValues(String keycode, int dronenum, float pm2, float pm10) {
		super();
		this.keycode = keycode;
		this.dronenum = dronenum;
		this.pm2 = pm2;
		this.pm10 = pm10;
	}
	public String getKeycode() {
		return keycode;
	}
	public void setKeycode(String keycode) {
		this.keycode = keycode;
	}
	public int getDronenum() {
		return dronenum;
	}
	public void setDronenum(int dronenum) {
		this.dronenum = dronenum;
	}
	public float getPm2() {
		return pm2;
	}
	public void setPm2(float pm2) {
		this.pm2 = pm2;
	}
	public float getPm10() {
		return pm10;
	}
	public void setPm10(float pm10) {
		this.pm10 = pm10;
	}
	@Override
	public String toString() {
		return "DroneValues [keycode=" + keycode + ", dronenum=" + dronenum + ", pm2=" + pm2 + ", pm10=" + pm10 + "]";
	}
	
	

}
