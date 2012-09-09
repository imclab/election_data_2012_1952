class Election {

  int electionYear;
  ArrayList<Candidate> candidates = new ArrayList();
  int totalCandidates;
  int index;


  Election(int _year) {
    electionYear = _year;
    totalCandidates = 1;
  } 

  void render(String _category) {
    // choose a category title and display it for each candidate

    // let's start easy and just make some circles. blue for democratic, red for republican
    // if there is a third candidate we'll fill them in with light grey    
    String searchTitle = _category;
    color[] colors = {
      color(0, 0, 255), color(255, 0, 0), color(155)
    };
    noStroke();

    float x = width/2;
    float y = height/2 - 50;
    float renderRadius = 600;
    float hole = 0.35*renderRadius;
    float start = radians(90);
    int index;
    
    for (int i=0; i<totalCandidates; i++) {
      Candidate thisCandidate = candidates.get(i);
      for (int j=0; j<thisCandidate.categories.size(); j++) {
        Category thisCategory = thisCandidate.categories.get(j);
        if (thisCategory.title.equals(searchTitle)) {
          float renderValue = start + radians(thisCategory.value/100 * 360);
          fill(colors[i]); // the first candidate is always a Democrat
          arc(x, y, renderRadius, renderRadius, start, renderValue); 
          start = renderValue; 
        }
      }
    }
 
    stroke(115);
    strokeWeight(3);
    for(int angle=0; angle<360; angle+=2){
     line(x, y, (x + cos(radians(angle))*(renderRadius/2)), (y + sin(radians(angle))*(renderRadius/2))); 
    }
    
    fill(115);
    noStroke();
    ellipse(x, y, hole, hole);     
    
  }
  
  
  void renderFlag(int _i, int _max){
    _i = _i + 1;
    if(mouseX > secWidth*_i - secWidth/2 && mouseX < secWidth*(_i+1) - secWidth/2){
       stroke(255);
       strokeWeight(1);
       line(secWidth*_i, graphBottom, secWidth*_i, graphTop);
       fill(255);
       rect(secWidth*_i, graphTop, secWidth, 20);
       textFont(yearFont, 12);
       fill(0);
       text(1952 + (_i-1)*4, secWidth*_i+15, graphTop+15);
    } else {
        stroke(115);
        fill(115);
        rect(secWidth*_i, graphTop, secWidth, 20);
        strokeWeight(1);
        line(secWidth*_i, graphBottom, secWidth*_i, graphTop);    
        stroke(255, 100);
        strokeWeight(1);
        line(secWidth*_i, graphBottom, secWidth*_i, graphBottom - _max);  
    }
  }
  
}

