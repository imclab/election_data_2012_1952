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

void setup() {
  allData = loadStrings(filename);
  //println(allData);

  parseData();
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
  String candidate = names[1];
  Election firstElection = new Election(electionYear);

}




