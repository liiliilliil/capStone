package capStone.model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;





public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	

	public UserDAO() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/cap_stone";	
			String dbID="tmdrl";
			String dbPassword="tmdrl";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn =DriverManager.getConnection(dbURL,dbID,dbPassword); 

		} catch (Exception e) {
			
		}
	}


	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM USER WHERE userID=?";
		try {
			pstmt=conn.prepareStatement(SQL); 
			pstmt.setString(1, userID); 
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -2;
	}
	

	
	public int join(User user) {
		String SQL="INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("오류가 발생했습니다.");
			// TODO: handle exception
		}
		return -2;
	}
	
	
}