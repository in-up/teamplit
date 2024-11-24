package dao;

import java.util.ArrayList;
import dto.Team;


public class TeamRepository{
	
	
	private ArrayList<Team> listOfTeams = new ArrayList<Team>();
	
	private static TeamRepository instance = new TeamRepository();

	public static TeamRepository getInstance(){
		return instance;
	} 
	
	
	public TeamRepository() {
	
		Team team1= new Team(1, "원팀", 6, "1234");
		team1.setT_description("[웹프로그래밍] 원팀정신으로 1등하기");
		team1.setT_manager_id("20210001");
		team1.setT_date("2024-11-24");
		team1.setT_filename("1.png");
		
		Team team2= new Team(2, "개발새발", 7, "1234");
		team2.setT_description("[오픈소스SW실습] 개발자의 발전을, 새로운 발견을. 개발새발 팀입니다.");
		team2.setT_manager_id("20220006");
		team2.setT_date("2024-11-24");
		team2.setT_filename("2.png");
		
		Team team3= new Team(3, "재개발조합", 10, "1234");
		team3.setT_description("[지능웹설계] 재개발조합은 우리학과 개발 생태계를 송두리째 바꿀 최강의 풀스택 개발 팀입니다.");
		team3.setT_manager_id("20230011");
		team3.setT_date("2024-11-24");
		team3.setT_filename("3.png");
		
		listOfTeams.add(team1);
		listOfTeams.add(team2);
		listOfTeams.add(team3);
		
		
	}
	public ArrayList<Team> getAllTeams() {
		return listOfTeams;
	}
	public Team getTeamById(String teamId) {
	    Team teamById = null;

	    try {
	        int teamIdInt = Integer.parseInt(teamId);

	        for (int i = 0; i < listOfTeams.size(); i++) {
	            Team team = listOfTeams.get(i);
	            if (team != null && team.getT_id() == teamIdInt) {
	                teamById = team;
	                break;
	            }
	        }
	    } catch (NumberFormatException e) {
	        System.err.println("Invalid teamId format: " + teamId);
	    }

	    return teamById;
	}
	public void addTeam(Team team) {
		listOfTeams.add(team);
	}

}
