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
int activeID  = 0;
float position;
boolean doLoop = true;

int speed = 20;

void setup()
{
  size(900, 700);
  smooth();
  font = createFont("Courier", 18);
  frameRate(30);

  textFont(font, fontSize);
  textAlign(LEFT);

}

void draw()
{
  background(255);
  fill(0);
  noFill();
  stroke(0);
  position = fontSize*2;
  
  for (int i = 0; i < program.length; i++) {
    //highlight active program line
    if (i == activeID) {
      rect(15, position+5, width, -fontSize-5);
    }
    printText(program[i]);
    position =fontSize*2 +(i + 1)*fontSize*1.3;
  }
  
  printText("");
  printText("Output:");
  

  for (String line: output) {
    printText(line);
  }
  if (doLoop) autoupdate();
}


private void printText(String text) {
  text(text, 20, position);
  position += fontSize*1.3;
}
    
void autoupdate()
{

  if ((frameCount % speed) == 0) {
    update();
  }
}

void update() {
  activeID++;
  
  if (activeID == 4) {
    output.add(list[output.size()]);
  }
  
  if (activeID >= program.length -1 && output.size() < list.length) {
    activeID = 3;
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
  activeID = 0;
}