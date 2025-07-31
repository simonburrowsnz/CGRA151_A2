// The starts positions of the line //
float startX = 250;
float startY = 250;

void setup(){
  size(500, 500);
  background(255);
  noSmooth();
}

void draw(){
  background(255);
  // If the mouse is pressed it uses my function //
  if(mousePressed && mouseButton == LEFT){
      stroke(255, 0, 0);
      drawLine(startX, startY, mouseX, mouseY);
  }
  // If you right click it changes the start position of the line //
  else if (mousePressed && mouseButton == RIGHT) {
    startX = mouseX;
    startY = mouseY;
  } 
  else{
    stroke(0, 0, 255);
    line(startX, startY, mouseX, mouseY);
  }
}


void drawLine(float startX, float startY, float endX, float endY){

  // Finds the diference between start and ending position on x&y //
  float xLength = endX - startX;
  float yLength = endY - startY;
  
  // Calculating values for midpoint algorythm //
  float A = -yLength;
  float B = xLength;
  float C = startX * endY - endX * startY;
  
  // Calculates wheather the line is going up/down/left/right //
  int stepX = xLength >= 0 ? 1 : -1;
  int stepY = yLength >= 0 ? 1 : -1;

  // Finds the length along the x&y axis //
  xLength = abs(xLength);
  yLength = abs(yLength);
  
  int currentX = Math.round(startX);
  int currentY = Math.round(startY);
    
  boolean isShallow = xLength >= yLength;
  
  // If it's shallow it iterates over x if not it iterates over y //
  if (isShallow) {
    // If it doesn't have this it doesn't work //
    if(stepX == 1){
      drawLine(endX, endY, startX, startY);
      return;
    }
    endX = Math.round(endX);
    
    // Calculates if it's going up or down for midpoint equation //
    float midpointY = (stepY > 0) ? currentY + 0.5f : currentY - 0.5f;
    // Midpoint equation //
    float k = A * (currentX + stepX) + B * midpointY + C;
  
    // Itterates untill it gets to the endpoint //
    while (currentX != endX) {
      point(currentX, currentY);
      currentX += stepX;

      if (stepY * k > 0){
        currentY += stepY;
        k += A * stepX + B * stepY;
      } else {
        k += A * stepX;
      }
    }
  } 
  else {
    // If it doesn't have this it doesn't work //
    if(stepY == -1){  
      drawLine(endX, endY, startX, startY);
      return;
    }
    endY = Math.round(endY);

    // Calculates if it's going up or down for midpoint equation //
    float midpointX = (stepX > 0) ? currentX + 0.5f : currentX - 0.5f;
    // Midpoint equation //
    float k = A * midpointX + B * (currentY + stepY) + C;

    // Itterates untill it gets to the endpoint //
    while (currentY != endY) {
      point(currentX, currentY);
      currentY += stepY;

      if (stepX * k > 0){    
        currentX += stepX;
        k += A * stepX + B * stepY;
      } else {
        k += B * stepY;
      }    
    }
  }
  
  // Draws the end point //
  point(endX, endY);  
}
