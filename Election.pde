class Election {

  int electionYear;
  ArrayList<Candidate> candidates = new ArrayList();
  int totalCandidates;


  Election(int _year) {
    electionYear = _year;
    totalCandidates = 1;
  } 

  void render() {
    // choose a category title and display it for each candidate

    // let's start easy and just make some circles. blue for democratic, red for republican
    // if there is a third candidate we'll fill them in with light grey    
    String searchTitle = "Women";
    color[] colors = {color(0,0,255), color(255,0,0), color(155)};
    noStroke();

    float x = width/2;
    float y = height/2;
    float renderRadius = 250;
    float hole = 0.7*renderRadius;
    float start = radians(90);
    
    for (int i=0; i<totalCandidates; i++){
      Candidate thisCandidate = candidates.get(i);
     for(int j=0; j<thisCandidate.categories.size(); j++){
       Category thisCategory = thisCandidate.categories.get(j);
       if(thisCategory.title.equals(searchTitle)){
         float renderValue = start + radians(thisCategory.value/100 * 360);
         fill(colors[i]); // the first candidate is always a Democrat
         arc(x, y, renderRadius, renderRadius, start, renderValue); 
         start = renderValue;         
      }
     }
    }
    fill(115);
    ellipse(x, y, hole, hole);
}


}

