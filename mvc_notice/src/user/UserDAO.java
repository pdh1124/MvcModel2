package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; //Connection : 데이터베이스에 접근해주는 하나의 객체를 의미
	private PreparedStatement pstmt; 
	private ResultSet rs;//ResultSet : 어떠한 정보를 담을 수 있는 하나의 객체
	
	 
	public UserDAO() {
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "admin";
			String dbPassword = "1234";
			
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); //오류 출력
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM MEMBER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); //데이터베이스에 삽입하는 형식으로 가져오기
			pstmt.setString(1, userID); //1번째 ?에 들어가는 값으로 매개변수로 받은 userID을 삽입
			rs = pstmt.executeQuery();//결과를 담을 수 있는 객체에다가 실행한 결과를 넣어준다.
			if(rs.next()) { //결과가 존재한다면 실행
				if(rs.getString(1).equals(userPassword)) { //매개변수로 받은 userID를 넣어서 sql문에 받은 userPassword가 매개변수로 받은 userPassword와 비교해서 같다면 실행.
					return 1; //로그인 성공 
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //rs가 없다면 if문을 실행하지 않고 넘어가기 떄문에 아이디가 없다.라는 뜻
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터 베이스 오류
	}
	
	//한명의 사용자를 입력 받을 수 있도록 한다.(회원가입)
	public int join(User user) {
		String SQL = "INSERT INTO MEMBER VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL); //데이터베이스에 삽입하는 형식으로 가져오기
			pstmt.setString(1, user.getUserID()); //1번째 ?에 들어가는 값으로 매개변수로 받은 userID을 삽입
			pstmt.setString(2, user.getUserPassword()); //2번째 ?에 들어가는 값으로 매개변수로 받은 userPassword을 삽입
			pstmt.setString(3, user.getUserName()); //3번째 ?에 들어가는 값으로 매개변수로 받은 userName을 삽입
			pstmt.setString(4, user.getUserGender()); //4번째 ?에 들어가는 값으로 매개변수로 받은 userGender을 삽입
			pstmt.setString(5, user.getUserEmail()); //5번째 ?에 들어가는 값으로 매개변수로 받은 userEmail을 삽입
			return pstmt.executeUpdate(); //sql에 실행한 결과를 넣어준다.
			//INSERT 라는 문장을 실행한 경우는 반드시 0이상의 숫자가 반환되기 떄문에 -1이 아닌경우는 성공적으로 회원가입이 이루어진것 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
