PFont font;
int fontSize = 18;
String [] program =  {"sentence = ['a', 'short', 'list']",
  "print('Iterating over the sentence:')",
  "for word in sentence:",
  "    //loop starts (indentation)",
  "    print(word)",
  "    //loop/indentation ends",
  "print('Done')"};
String[] list =  {"a", "short", "list"};
ArrayList<String> output= new ArrayList<String>();
int activeID = 0;
float position;
boolean doLoop = true;
int delayFrame = 30;
float lineSpacing = fontSize*1.3;
String word = "";

void setup() {
  size(600, 600);
  smooth();
  font = createFont("Courier", 18);
  frameRate(30);
  textFont(font, fontSize);
  textAlign(LEFT);
}

void draw() {
  background(255);
  fill(0);
  noFill();
  stroke(0);
  position = fontSize*2;
  
  for (int i = 0; i < program.length; i++) {
    //highlight active program line
    if (i == activeID) {
      rect(15, position+5, width-30, -fontSize-5);
    }
    printText(program[i]);
    position =fontSize*2 +(i + 1)*lineSpacing;
  }
  
  printText("");
  printText("Output:");
  
  for (String line: output) {
    printText(line);
  }
  drawFigure();
  
  if (doLoop) autoupdate();
}

void textbox(String content, String label,int x,int y){
  int boxWidth = 120;
  int boxHeight = 30;
  x = x-boxWidth/2;
  rect(x, y+2, boxWidth, boxHeight);
  text(content, x+10, y+lineSpacing);
  text(label, x, y-5);
}

private void drawFigure() {
  int top = height/2;
  int bottom = height;
  int distance = (bottom - top)/3;
  int listPos = top + distance;
  textbox("'a'", "sentence[0]", width/4, listPos);
  textbox("'short'", "sentence[1]", width/2, listPos);
  textbox("'list'", "sentence[2]", width-width/4, listPos);
  textbox(word, "word", width/2, bottom - distance);
}

private void printText(String content) {
  text(content, 20, position);
  position += lineSpacing;
}
    
void autoupdate() {

  if ((frameCount % delayFrame) == 0) {
    update();
  }
}

void update() {
  activeID++;
  
  if (activeID == 4) {
    word = list[output.size()];
    output.add(word);
  }
  
  if (activeID >= program.length -1 && output.size() < list.length) {
    activeID = 3;
    word = list[output.size()];
  }
 
  if (activeID == 6) {
    output.add("Done");
  }
  
  if (activeID > 8) {
    reset();
  }
}

void reset() {
  output.clear();
  word = "";
  activeID = 0;
}