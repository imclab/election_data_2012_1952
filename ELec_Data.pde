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
ArrayList<Election> allElections = new ArrayList(0);

void setup() {
  allData = loadStrings(filename);
  //println(allData);

  parseData();
  //checkData();
}

void parseData() {

  int[] years = int(allData[0].split(","));
  String[] names = allData[1].split(",");

  // make the first Election so we have something to compare to
  init_Elections();

  Election thisElection;
  for (int column=3; column<years.length-1; column++) {
    int electionYear = years[column];
    
    if (electionYear == years[column-1]) {
      thisElection = allElections.get(allElections.size()-2);
      String candidateAdd = names[column];
      thisElection.candidates.add(candidateAdd);
      println("add: " + candidateAdd);
    } 
    else {
      thisElection = new Election(electionYear);
      println("____________" + thisElection.electionYear);
      String thisCandidate = names[column];
      thisElection.candidates.add(thisCandidate);
      println(thisCandidate);
      allElections.add(thisElection);
    }
    for (int i=2; i<allData.length; i++) {
      String[] thisRow = allData[i].split(",");
      String title = thisRow[0];
      Category thisCategory = new Category(title, thisElection.candidates.size());
      for (int j=0; j<thisElection.candidates.size(); j++) {
        thisCategory.values[j] = int(thisRow[column+j]);
        thisElection.categories.add(thisCategory);
      }
    }
  }
}

  void init_Elections() {
    int[] years = int(allData[0].split(","));
    String[] names = allData[1].split(",");

    int electionYear = years[1];
    Election firstElection = new Election(electionYear);
    String firstCandidate = names[1];
    firstElection.candidates.add(firstCandidate);

    String candidateAdd1 = names[2];
    firstElection.candidates.add(candidateAdd1); 

    for (int i=2; i<allData.length; i++) {
      String[] thisRow = allData[i].split(",");
      String title = thisRow[0];
      Category thisCategory = new Category(title, firstElection.candidates.size());
      thisCategory.values[0] = int(thisRow[1]);
      thisCategory.values [1] = int(thisRow[2]);
      firstElection.categories.add(thisCategory);
    }
    allElections.add(firstElection);
    //checkData();
  }



  void checkData() {
    for (Election e:allElections) {
      println(e.electionYear);
      println("-----------------------");
      for (int i=0; i<e.candidates.size(); i++) {
        String thisCandidate = e.candidates.get(i);
        println("<< " + thisCandidate + " >>");
        //      for (int j=0; j<e.categories.size(); j++) {
        //        Category thisCategory = e.categories.get(j);
        //        println(thisCategory.title + ": " + thisCategory.values[i]);
        //      }
              }
      println(" ");
    }
  }

