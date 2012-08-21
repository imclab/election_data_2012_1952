/* 
 Election Data 
 A series of tutorials for importing table data 
 and making basic interactive visuals
 
 Focus is comparing voter figures for all candidates of one election
 User chooses topic
 The values for that election appear in a ring
 The values for the topic over time appear below as a graph with a marker for current year
 User can slide along the graph to change which year is shown above as a ring.
 
 Matthew Epler 2012
 for School of Data
 */

String filename = "US_Races.csv";
String[] allData;
ArrayList<Election> allElections = new ArrayList();

void setup() {
  allData = loadStrings(filename);
  //println(allData);

  parseData();
  checkData();
}

void parseData() {
  /* the first String is all years
   for each cell in this line, check to see if an existing election exists
   if no, create a new election, add the candidate and values below that cell
   the first candidate will always be a democrat
   if yes, add the candidate and his values
   the second candidate will always be a republican
   the third will always be referred to as 'other'
   */

  // first let's make a single column and use it as a reference
  // we start at 1 because cell '0' is blank
  int[] years = int(allData[0].split(","));
  String[] names = allData[1].split(",");
  // the first column we have is Obama, 2008. It is in the second column from the left,
  // or position 1 in the array. Make an election object with that year, and that candidate.
  int electionYear = years[1];
  Election firstElection = new Election(electionYear);
  // next let's look for the name under that year and add it to the Election
  // we'll need to create an ARray List to hold these cuz we gotta be flexible
  String candidate1 = names[1];
  firstElection.candidates.add(candidate1);
  // now let's check the next column and see if we have another candidate for this year
  if(years[2] == electionYear){
   String candidateAdd = names[2];
   firstElection.candidates.add(candidateAdd); 
  }
  firstElection.totalCandidates = firstElection.candidates.size();
  // now let's get all the categories and throw them in the election
  // we're using a 2D array for this.
  for(int i=2; i<allData.length; i++){
    String[] thisRow = allData[i].split(",");
    String title = thisRow[0];
    Category thisCategory = new Category(title, firstElection.totalCandidates);
    thisCategory.values[0] = int(thisRow[1]);
    thisCategory.values [1] = int(thisRow[2]);
    firstElection.categories.add(thisCategory);
  }
  allElections.add(firstElection);
}

void checkData(){
 for(Election e:allElections){
   println(e.electionYear);
   println("-----------------------");
   for(int i=0; i<e.candidates.size(); i++){
    String thisCandidate = e.candidates.get(i);
     println("<< " + thisCandidate + " >>");
     for(int j=0; j<e.categories.size(); j++){
      Category thisCategory = e.categories.get(j);
      println(thisCategory.title + ": " + thisCategory.values[i]);
     }
   }
 }
}




