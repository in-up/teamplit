package dto;

import java.io.Serializable;

public class Team implements Serializable {

	private static int latest = 1;

	private int t_id; 		    // 팀ID (자동증분)
	private String t_name;			// 팀명
	private int t_capacity; 	    // 팀 최대정원
	private String t_manager_id;	// 팀장 학번
	private String t_description; 	// 팀 설명
	private String t_invite_code;   // 초대 코드
	private String t_date; 		// 팀 생성일
	private String t_filename;     	// 파일 이름
	

	public Team() {
		super();
}

	public Team(Integer t_id, String t_name, Integer t_capacity, String t_invite_code) {
		this.t_id = t_id;
		this.t_name = t_name;
		this.t_capacity = t_capacity;
		this.t_invite_code = t_invite_code;
	}

	public int getT_id() {
		return t_id;
	}

	public void setT_id(int t_id) {
		this.t_id = t_id;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public int getT_capacity() {
		return t_capacity;
	}

	public void setT_capacity(int t_capacity) {
		this.t_capacity = t_capacity;
	}

	public String getT_manager_id() {
		return t_manager_id;
	}

	public void setT_manager_id(String t_manager_id) {
		this.t_manager_id = t_manager_id;
	}

	public String getT_description() {
		return t_description;
	}

	public void setT_description(String t_description) {
		this.t_description = t_description;
	}

	public String getT_invite_code() {
		return t_invite_code;
	}

	public void setT_invite_code(String t_invite_code) {
		this.t_invite_code = t_invite_code;
	}

	public String getT_date() {
		return t_date;
	}

	public void setT_date(String t_date) {
		this.t_date = t_date;
	}

	public String getT_filename() {
		return t_filename;
	}

	public void setT_filename(String t_filename) {
		this.t_filename = t_filename;
	}

}
