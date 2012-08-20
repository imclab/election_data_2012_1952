class Election{
  
 int electionYear;
 ArrayList<String> names = new ArrayList(); // some elections have more than two so it needs to be flexible
 
 Election(int _year, String _firstCandidateName){
  electionYear = _year;
  names.add(_firstCandidateName);
 } 
  
}
