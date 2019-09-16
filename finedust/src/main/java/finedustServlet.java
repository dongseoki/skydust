

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class finedustServlet
 */
@WebServlet("/finedust")
public class finedustServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public finedustServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DroneValuesDao dao = new DroneValuesDao();
		SimpleDateFormat formatter= new SimpleDateFormat("yyyyMMddhh");
        Date date = new Date(System.currentTimeMillis());
        
        Calendar cal = new GregorianCalendar();
        cal.add(Calendar.HOUR, +8);
        for(int i=0;i<24;i++){
        	DroneValues dronevalues = dao.getDroneValue(""+formatter.format(cal.getTime()));
			request.setAttribute(""+i, dronevalues.toString());
        	cal.add(Calendar.HOUR, -1);
        }
		//RequestDispatcher requestDispatcher = request.getRequestDispatcher("/finedust.jsp");
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/finedust2.jsp");
        requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
