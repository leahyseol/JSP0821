package com.exam.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.MemberVO;

public class MemberDao {

	private static MemberDao instance = new MemberDao();

	public static MemberDao getInstance() {
		return instance;
	}

	private MemberDao() {
	}

	public int insertMember(MemberVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;

		try {
			con = DBManager.getConnection();
			// 3단계: sql문 준비
			String sql = "INSERT INTO member (id,passwd,name,age,gender,email,reg_date) ";
			sql += " VALUES (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPasswd());
			pstmt.setString(3, vo.getName());
			pstmt.setInt(4, vo.getAge());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getEmail());
			pstmt.setTimestamp(7, vo.getRegDate());
			// 4단계: sql문 실행
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(con, pstmt);
		}
		return rowCount;
	} // insertMember method

	public MemberVO getMember(String id) {
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBManager.getConnection();
			// 3단계: sql문 준비
			String sql = "SELECT * FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계: sql문 실행
			rs = pstmt.executeQuery();
			// 5단계: rs 데이터 사용
			if (rs.next()) {
				memberVO = new MemberVO();

				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));

				// rs.getInt("age"); interger is not null
				String strAge = rs.getString("age");
				if (strAge != null) { // "33"
					memberVO.setAge(Integer.parseInt(strAge));
				}

				memberVO.setGender(rs.getString("gender"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(con, pstmt, rs);
		}
		return memberVO;
	}

	public MemberVO loginCheckAndGetMember(String id, String passwd) {
		// int check = -1; // -1 아이디 불일치. 0 패스워드 불일치. 1 일치함
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBManager.getConnection();

			// 3단계: sql문 준비
			String sql = "SELECT * FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계: sql문 실행
			rs = pstmt.executeQuery();
			// 5단계: rs 데이터 사용

			if (rs.next()) {
				// 아이디 있음
				if (passwd.equals(rs.getString("passwd"))) {
					memberVO = new MemberVO();

					memberVO.setId(rs.getString("id"));
					memberVO.setPasswd(rs.getString("passwd"));
					memberVO.setName(rs.getString("name"));

					// rs.getInt("age"); interger is not null
					String strAge = rs.getString("age");
					if (strAge != null) { // "33"
						memberVO.setAge(Integer.parseInt(strAge));
					}

					memberVO.setGender(rs.getString("gender"));
					memberVO.setEmail(rs.getString("email"));
					memberVO.setRegDate(rs.getTimestamp("reg_date"));
				} else {
					memberVO = null;
				}
			} else { // 아이디 없음
				memberVO = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(con, pstmt, rs);
		}
		return memberVO;
	}// userCheck method

	// bring a whole list of membership
	public List<MemberVO> getMembers() {
		List<MemberVO> list = new ArrayList<MemberVO>();

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			// 1st : DB Driver loading
			// 2nd : DB connected
			con = DBManager.getConnection();
			// 3rd : prepared sql statement
			sql = "SELECT* FROM member ORDER BY id ASC";
			stmt = con.createStatement();
			// 4th steps : execute sql => rs created
			rs = stmt.executeQuery(sql);
			// 5th : while statement rs.next() if there is another line,
			// java bean object MemberVO created <- rs line 1 saved
			// java bean => add object

			while (rs.next()) {
				MemberVO memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));

				// rs.getInt("age"); interger is not null
				String strAge = rs.getString("age");
				if (strAge != null) { // "33"
					memberVO.setAge(Integer.parseInt(strAge));
				}

				memberVO.setGender(rs.getString("gender"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));

				list.add(memberVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(con, stmt, rs);
		}
		return list;
	}

	// 회원정보 수정하기 메소드
	// 매개변수 memberVO에 passwd필드는 수정의 대상이 아니라
	// 본인 확인 용도로 사용
	public int updateMember(MemberVO memberVO) {
		int result = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			// 1단계: DB 드라이버 로딩
			// 2단계: DB연결
			con = DBManager.getConnection();
			// 3단계: sql문 준비
			sql = "SELECT passwd FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVO.getId());
			// 4단계: sql문 실행 -> rs 생성
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (memberVO.getPasswd().equals(rs.getString("passwd"))) {
					pstmt.close(); // 앞에 SELECT문 수행한 pstmt 닫기

					sql = "UPDATE member SET name=?, age=?, gender=?, email=? WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberVO.getName());

					pstmt.setObject(2, memberVO.getAge()); // age필드값이 null일수 있으면
					// pstmt.setInt(2, memberVO.getAge()); // age필드값이 항상 있으면

					pstmt.setString(3, memberVO.getGender());
					pstmt.setString(4, memberVO.getEmail());
					pstmt.setString(5, memberVO.getId());
					// 실행
					pstmt.executeUpdate();

					result = 1;

				} else {
					result = 0; // 패스워드 불일치로 수정실패를 의미함
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(con, pstmt, rs);
		}
		return result;

	}// insertMember method
}