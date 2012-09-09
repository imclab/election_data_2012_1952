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
ArrayList<Candidate> allCandidates = new ArrayList();

int renderYear;
float secWidth;
int graphTop;
int graphBottom;
int graphHeight;
int graphIndex;

PFont nameFont;
PFont yearFont;


void setup() {
  size(1000, 800);
  background(115);
  smooth();
  nameFont = loadFont("Arial-Black-48.vlw");
  yearFont = loadFont("AppleGothic-48.vlw");

  allData = loadStrings(filename);
  parseData();
  //checkData();
  
  secWidth = width/(allElections.size()+1);
  graphTop = height - 150;
  graphBottom = height - 50;
  graphHeight = graphBottom - graphTop;

}

void draw() {
  renderYear = 2000;
  String renderCategory = "Women";
  renderGraph(renderCategory);
  for (Election e:allElections) {
    if (e.electionYear == renderYear) {
      e.render(renderCategory);
    }
  }  
  noStroke();
  textFont(yearFont, 66);  
  fill(0);
  rect(0, 0, renderCategory.length()*65, 100);
  fill(225);
  rect(0, 100, 250, 100);
  text(renderCategory, 25, 75);
  fill(0);
  text(renderYear, 25, 170);
}

void parseData() {
  // make the first Election so we have something to compare to
  init_Elections();
  //checkData();

  int[] years = int(allData[0].split(","));
  String[] names = allData[1].split(",");

  for (int column=3; column<years.length; column++) {
    int electionYear = years[column];

    // if the year is the same as the previous column, 
    // add this candidate to the last election in the Array List
    if (electionYear == years[column-1]) {
      Election thisElection = allElections.get(allElections.size()-1);
      Candidate thisCandidate = new Candidate(names[column], electionYear, thisElection.totalCandidates + 1);
      // for every row of data, match the candidate with the value for that row
      for (int i=2; i<allData.length; i++) {
        String[] thisRow = allData[i].split(",");
        String title = thisRow[0];
        int value = int(thisRow[column]);
        Category thisCategory = new Category(title, value);
        thisCandidate.categories.add(thisCategory);
      }
      thisElection.candidates.add(thisCandidate);
      thisElection.totalCandidates++;      
      allCandidates.add(thisCandidate);
    } 
    else {  // create a new election and add the first candidate
      Election thisElection = new Election(electionYear);
      Candidate thisCandidate = new Candidate(names[column], electionYear, 1);
      // for every row of data, match the candidate with the value for that row
      for (int i=2; i<allData.length; i++) {
        String[] thisRow = allData[i].split(",");
        String title = thisRow[0];
        int value = int(thisRow[column]);
        Category thisCategory = new Category(title, value);
        thisCandidate.categories.add(thisCategory);
      }
      thisElection.candidates.add(thisCandidate);
      allElections.add(thisElection);
      thisElection.index = allElections.size();
      allCandidates.add(thisCandidate);
    }
  }
}

void init_Elections() {
  int[] years = int(allData[0].split(","));
  String[] names = allData[1].split(",");

  int electionYear = years[1];
  Election firstElection = new Election(electionYear);
  firstElection.index = 1;

  Candidate firstCandidate = new Candidate(names[1], electionYear, 1);
  firstElection.candidates.add(firstCandidate);
  for (int i=2; i<allData.length; i++) {
    String[] thisRow = allData[i].split(",");
    String title = thisRow[0]; 
    int value = int(thisRow[1]); // same column as the name
    Category thisCategory = new Category(title, value);
    firstCandidate.categories.add(thisCategory);
  }
  allCandidates.add(firstCandidate);

  Candidate secondCandidate = new Candidate(names[2], electionYear, 2);
  firstElection.candidates.add(secondCandidate);
  for (int i=2; i<allData.length; i++) {
    String[] thisRow = allData[i].split(",");
    String title = thisRow[0]; 
    int value = int(thisRow[2]);
    Category thisCategory = new Category(title, value);
    secondCandidate.categories.add(thisCategory);
  }
  allCandidates.add(secondCandidate);

  allElections.add(firstElection);
}

void renderGraph(String _category) {
  int demCounter = 0;
  int repCounter = 0;
  int oCounter = 0;
  float[] democrats = new float[allElections.size()];
  float[] republicans = new float[allElections.size()];
  float[] other = new float[allElections.size()];

  for (int i=allElections.size()-1; i>=0; i--) {
    Election thisElection = allElections.get(i);
    for (Candidate c:thisElection.candidates) {
      if (c.index == 1) {
        for (Category cat:c.categories) {
          if (cat.title.equals(_category)) {
            democrats[demCounter] = cat.value;
            demCounter++;
          }
        }
      } 
      else if (c.index == 2) {
        for (Category cat:c.categories) {
          if (cat.title.equals(_category)) {
            republicans[repCounter] = cat.value; 
            repCounter++;
          }
        }
      } 
      else if (c.index == 3) {
        for (Category cat:c.categories) {
          if (cat.title.equals(_category)) {
            other[oCounter] = cat.value; 
            oCounter++;
          }
        }
      }
    }
  }

  strokeWeight(3);
  noFill();

  beginShape(); // for Dems
  stroke(0, 0, 255);
  for (int i=0; i<democrats.length; i++) {
    float thisValue = map(democrats[i], 0, 100, 0, graphHeight);
    vertex(secWidth*(i+1), graphBottom - thisValue);
    //ellipse(secWidth*(i+1), graphBottom - thisValue, 3, 3);
  }
  endShape();

  beginShape(); // for Repubs
  stroke(255, 0, 0);
  for (int i=0; i<republicans.length; i++) {
    float thisValue = map(republicans[i], 0, 100, 0, graphHeight);
    vertex(secWidth*(i+1), graphBottom - thisValue);
    //ellipse(secWidth*(i+1), graphBottom - thisValue, 3, 3);
  }
  endShape();

  beginShape(); // for Other
  stroke(155);
  for (int i=0; i<other.length; i++) {
    float thisValue = map(other[i], 0, 100, 0, graphHeight);
    vertex(secWidth*(i+1), graphBottom - thisValue);
    //ellipse(secWidth*(i+1), graphBottom - thisValue, 3, 3);
  }
  endShape();
  
  for(int i=0; i<allElections.size(); i++){
   Election thisElection = allElections.get(0);
   int maxValue = int(max(democrats[i], republicans[i]));
   thisElection.renderFlag(i, maxValue);
  }
  
  strokeWeight(5);
  stroke(0);
  line(secWidth, graphBottom, width - secWidth - 9, graphBottom);
  
}


void checkMouse(){

}


void checkData() {  

  /* check all data for one election */
  //  int checkYear = 1952;
  //  
  //  for(Election e:allElections){
  //   if(e.electionYear == checkYear){
  //    println("Election Year= " + checkYear);
  //    for(Candidate c:e.candidates){
  //     println("<< " + c.name + " >>");
  //     for(Category cat:c.categories){
  //      println(cat.title + ": " + cat.value);
  //     }
  //     println(" ");
  //    }
  //   } 
  //  }

  /* check dates and names for all elections */
  for (Election e:allElections) {
    print("--------------");
    println(e.electionYear);
    for (Candidate c:e.candidates) {
      println("<< " + c.name + " >>");
      //      for (int i=0; i<c.categories.size(); i++) {
      //        Category thisCategory = c.categories.get(i);
      //        println(thisCategory.title + ": " + thisCategory.value);
      //      }
    }
    println(" ");
  }
}

