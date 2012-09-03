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
    String categoryTitle = "Women";
    color col;
    noStroke();

    for (Candidate c:candidates) {
      for (Category cat:c.categories) {
        if (cat.title.equals(categoryTitle)) {
          if (c.index == 1) { // the first candidate is always a democrat
            col = color(0, 0, 255);
          } 
          else if (c.index == 2) {
            col = color(255, 0, 0);
          } else {
            col = color(155);
          }
            
          fill(col);
          ellipse(random(0, width), random(0, height), cat.value*2, cat.value*2);
        }
      }
    }
  }
}

