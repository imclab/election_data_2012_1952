/* 
  Election Data 
   A series of tutorials for importing table data 
   and making basic interactive visuals
   
   Matthew Epler 2012
   for School of Data
*/

String filename = "US_Races.csv";
String[] allData;

void setup(){
  allData = loadStrings(filename);
  println(allData);
}
