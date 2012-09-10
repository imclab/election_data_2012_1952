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

float secWidth;
int graphTop;
int graphBottom;
int graphHeight;
int graphIndex;
float margin;

PFont nameFont;
PFont yearFont;

int renderYear = 2000;
String renderCategory = "Women";
int yearFontSize = 50;
int nameFontSize = 28;
int boxHeight = 80;

boolean categoryMenu = false;
boolean yearMenu = false;

//_________________________________________________setup()______________________________
void setup() {
  size(1000, 800);
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
  margin = .04 * width;

}

//_________________________________________________draw()______________________________
void draw() {
  if(categoryMenu == true){
   displayCategoryMenu(); 
  } else if(yearMenu == true){
   displayYearMenu(); 
  } else {
  background(115);
  for (Election e:allElections) {
    if (e.electionYear == renderYear) {
      e.render(renderCategory);
    }
  }  
  noStroke();
  textFont(yearFont, yearFontSize);  
  fill(240);
  rect(0, margin, textWidth(renderCategory)*1.25 + margin, boxHeight);
  fill(25);
  //rect(0, boxHeight, textWidth("year" + "000"), boxHeight); // this will be obsolete in the year 10,000
  text(renderCategory, margin, margin + boxHeight - yearFontSize/2);
  //fill(0);
  //text(renderYear, textWidth("a"), boxHeight*2 - yearFontSize/2);
  
  renderGraph(renderCategory);
  
} 
}

//_________________________________________________parseData()______________________________
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
      thisElection.totalCandidates = 1;
      thisElection.index = allElections.size();
      allCandidates.add(thisCandidate);
    }
  }
}

//_________________________________________________initElections()______________________________
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
  firstCandidate.index = 1;

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
  secondCandidate.index = 2;
  firstElection.totalCandidates = 2;
  firstElection.index = 1;
  allElections.add(firstElection);
}

//_________________________________________________renderGraph()______________________________
void renderGraph(String _category) {
  int demCounter = 0;
  int repCounter = 0;
  float[] democrats = new float[allElections.size()];
  float[] republicans = new float[allElections.size()];
  
  ArrayList<Election> others = new ArrayList();  
  for(Election e:allElections){
   if(e.totalCandidates > 2){
    others.add(e); 
  }
  }

  for (int i=allElections.size()-1; i>=0; i--) {
    Election thisElection = allElections.get(i);
    for (int j=0; j<thisElection.totalCandidates; j++) {
      if (j+1 == 1) {
       Candidate thisCandidate = thisElection.candidates.get(j);      
        for (Category cat:thisCandidate.categories) {
          if (cat.title.equals(_category)) {
            democrats[demCounter] = cat.value;
            demCounter++;
          }
        }
      } 
      else if (j+1 == 2) {
        Candidate thisCandidate = thisElection.candidates.get(j); 
        for (Category cat:thisCandidate.categories) {
          if (cat.title.equals(_category)) {
            republicans[repCounter] = cat.value; 
            repCounter++;
          }
        }
      } 
    }
  }
  
  // draw flags and marker lines
  for(int i=0; i<allElections.size(); i++){
   Election thisElection = allElections.get(i);
   int maxValue = int(max(democrats[i], republicans[i]));
   stroke(255,100);
   strokeWeight(1);
   line(secWidth*thisElection.index, graphBottom,secWidth*thisElection.index, graphBottom - maxValue);
   thisElection.renderFlag(i);   
  }
  
  
  // draw the lines
  strokeWeight(3);
  noFill();
  beginShape(); // for Dems
  stroke(#0D3574);
  for (int i=0; i<democrats.length; i++) {
    float thisValue = map(democrats[i], 0, 100, 0, graphHeight);
    vertex(secWidth*(i+1), graphBottom - thisValue);
    //ellipse(secWidth*(i+1), graphBottom - thisValue, 3, 3);
  }
  endShape();

  beginShape(); // for Repubs
  stroke(#FF3434);
  for (int i=0; i<republicans.length; i++) {
    float thisValue = map(republicans[i], 0, 100, 0, graphHeight);
    vertex(secWidth*(i+1), graphBottom - thisValue);
    //ellipse(secWidth*(i+1), graphBottom - thisValue, 3, 3);
  }
  endShape();
  
  // bottom line
  strokeWeight(5);
  stroke(25);
  line(secWidth, graphBottom, width - secWidth, graphBottom);

  stroke(210); // for others
  strokeWeight(2); 
  for(int i=0; i<others.size(); i++){
   Election thisElection = others.get(i);
   Candidate thisCandidate = thisElection.candidates.get(2);
   for(Category cat:thisCandidate.categories){
    if(cat.title.equals(_category)){
     float thisValue = map(cat.value, 0, 100, 0, graphHeight);
     ellipse(width - secWidth*thisElection.index - 8, graphBottom - thisValue, 5, 5);
    } 
   }
  }
}

//_________________________________________________mouseReleased()______________________________
void mouseReleased(){
  for(int i=1; i<allElections.size()+1; i++){
    if(mouseX > secWidth*i - secWidth/2 && mouseX < secWidth*(i+1) - secWidth/2 && mouseY > graphTop){
      Election thisElection = allElections.get(allElections.size()-i);
      renderYear = thisElection.electionYear;
    }
  }
  
  if(mouseY < 100 && mouseX < renderCategory.length()*60){
  categoryMenu = !categoryMenu;
  } 
  
  if(mouseY > 100 && mouseY < 200 && mouseX < 250){
  yearMenu = !yearMenu;
  }
}


//_________________________________________________displayCategoryMenu()______________________________
void displayCategoryMenu(){ 
 int heightTracker = 0;
 int rowCounter = 0;

 for(int i=2; i<allData.length; i++){
  float boxX = textWidth(renderCategory)+50 + (rowCounter *200);
  
  String[] thisRow = allData[i].split(",");
  strokeWeight(1);
  
  if(mouseX > boxX && mouseX < boxX + 200 && mouseY > heightTracker && mouseY < heightTracker + 20){
  fill(255);
  rect(boxX, heightTracker, 200, 20);
  fill(0);
  textFont(yearFont, 12);
  text(thisRow[0], boxX+5, heightTracker + 15);
   if(mousePressed){
    renderCategory = thisRow[0];
    categoryMenu = false; 
   }
  } else {
  fill(0);
  stroke(255);
  rect(boxX, heightTracker, 200, 20);
  fill(255);
  textFont(yearFont, 12);
  text(thisRow[0], boxX+5, heightTracker + 15);
  }
  
  heightTracker += 20;
  
  if(heightTracker > height - 40){
   heightTracker = 0;
   rowCounter ++; 
  }
 }
}

void displayYearMenu(){
  
}




