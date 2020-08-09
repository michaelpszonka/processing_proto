ControlPanel cp = new ControlPanel();
ArrayList<Circle> circles = new ArrayList<Circle>();
int CIRCLE_SIZE = 10;
int BUTTON_SIZE = 33;
color selectColor = #FFC0CB;


void setup() {
  size(640, 360);
  frameRate(30);
  ellipseMode(RADIUS);
}

void draw() {
  background(255);
  line(0, height * .75, width, height * .75);
  cp.update(mouseX, mouseY);
  fill(selectColor);
  for(Circle c : circles) {
     c.xPos = c.xPos + (c.xSpeed * c.xDirection);
     c.yPos = c.yPos + (c.ySpeed * c.yDirection);
     
     // Test to see if the shape exceeds the boundaries of the screen
    // If it does, reverse its direction by multiplying by -1
    if (c.xPos > .75* (width-c.diameter) || c.xPos < c.diameter) {
      c.xDirection *= -1;
    }
    if (c.yPos > .75 * (height-c.diameter) || c.yPos < c.diameter) {
      c.yDirection *= -1;
    }
      // Draw the shape
      ellipse(c.xPos, c.yPos, c.diameter, c.diameter);
  }

}    
    
void mousePressed() {
      if(cp.overIncrement) {
        circles.add(new Circle(10)); 
        print(circles.size());
     }
     else if(cp.overDecrement) {
       if(circles.size() > 0) {
         circles.remove(circles.size() - 1);
       }
      print(circles.size());
   }
}

class ControlPanel {
  boolean overIncrement = false;
  boolean overDecrement = false; 
  ActionButton incrementBtn = new ActionButton((width/2 + BUTTON_SIZE / 2 + 10), 320,  "ADD"); //position of add circle btn
  ActionButton decrementBtn = new ActionButton((3 * (width/2 + BUTTON_SIZE / 2) + 10), 320, "REMOVE"); //position of remove circle btn

  
  void update(int x, int y) {
      if(isOverIncrement(incrementBtn.xPos, incrementBtn.yPos, BUTTON_SIZE)) {
          overIncrement = true;
          overDecrement = false;
      } 
      else if(isOverDecrement(decrementBtn.xPos, decrementBtn.yPos, BUTTON_SIZE)) {
          overDecrement = true;
          overIncrement = false;
      }
      else {
        overDecrement = false;
        overIncrement = false;
      }
     fill(incrementBtn.btnColor);
     circle(incrementBtn.xPos, incrementBtn.yPos, BUTTON_SIZE);
     fill(decrementBtn.btnColor);
     circle(decrementBtn.xPos, decrementBtn.yPos, BUTTON_SIZE);
  }

  boolean isOverIncrement(float x, float y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
   }
   
   boolean isOverDecrement(float x, float y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }
}


class Circle {
    int diameter;
    color c = #0000FF;
    float xPos = random(width)/2,  yPos = random(height)/2;
    float xSpeed = 2.5;
    float ySpeed = 2.1;
    int xDirection = 1;
    int yDirection = 1;
    
    Circle(int size) {
       diameter = size; 
    }
}

class ActionButton {
  String text;
  float xPos;
  float yPos;
  color btnColor;
  ActionButton(float x, float y, String action) {
    xPos = x;
    yPos = y; 
    if(action == "ADD") {
      text = "Add";
      btnColor = #32CD32; //green
     } 
     else if(action == "REMOVE") {
       text = "Remove";
       btnColor = #ff0000; //red
     }
  }
}
