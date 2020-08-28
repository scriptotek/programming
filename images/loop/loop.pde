import java.util.StringJoiner;
PFont font;
int fontSize = 16;
String[] list =  {"a", "short", "list"};

//Components to build the python definition of the list
String delimiter = "', '";
String prefix = "sentence = ['";
String postfix = "']";
String listPython = String.join(delimiter, list);

String[] program =  {prefix + listPython + postfix, //we make the first program line
  "print('Iterating over the sentence:')",
  "for word in sentence:",
  "    # loop starts (indentation)",
  "    print(word)",
  "    # loop/indentation ends",
  "print('Done')"};
ArrayList<String> output= new ArrayList<String>();
int activeID = 0;
boolean doLoop = true;
int delayFrame = 30;
float lineSpacing = fontSize*1.3;
String word = "";
int count;

void setup() {
  size(500, 500);
  smooth();
  font = createFont("Courier", fontSize);
  frameRate(30);
  textFont(font, fontSize);
  textAlign(LEFT);
}

void draw() {
  background(255);
  fill(0);
  noFill();
  stroke(0);
  
  drawText();
  drawFigure();

  if (doLoop) autoupdate();
}

void drawText() {
  pushMatrix();
  //left+top margin
  translate(15, fontSize*2);

  for (int i = 0; i < program.length; i++) {
    //highlight active program line
    if (i == activeID) {
      rect(0, 5, width-30, -fontSize-5);
    }
    printText(program[i]);
  }
  
  printText("");
  printText("Output:");
  
  for (String line: output) {
    printText(line);
  }
  popMatrix();
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
  int wordPos = bottom - distance;
  textbox("'a'", "sentence[0]", width/4, listPos);
  textbox("'short'", "sentence[1]", width/2, listPos);
  textbox("'list'", "sentence[2]", width-width/4, listPos);
  textbox("".equals(word) ? "" : "'"+word+"'", "word", width/2, wordPos);
  switch (count) {
    case 1:
      arrow(width/2, wordPos, width/4+40, listPos+40);
      break;
    case 2:
      arrow(width/2, wordPos, width/2, listPos+40);
      break;
    case 3:
      arrow(width/2, wordPos, width-width/4-40, listPos+40);
      break;
  }
}

private void printText(String content) {
  text(content, 20, 0);
  translate(0, lineSpacing);
}
    
void autoupdate() {

  if ((frameCount % delayFrame) == 0) {
    update();
  }
}

void update() {
  activeID++;
  
  if (activeID >= program.length -1 && count < list.length) {
    activeID = 3;
  }
  
  if (activeID == 1) {
    output.add("Iterating over the sentence:");
  }
  
  if (activeID == 3) {
    word = list[count];
    count++;
  }
  
  if (activeID == 4) {
    output.add(word);
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
  count = 0;
  activeID = 0;
}

void mousePressed () {
  doLoop = !doLoop;
}

void keyPressed () {
  if (key == 'l') {
    doLoop = !doLoop;
  } else {
    update();
    redraw();
  }
}

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}
