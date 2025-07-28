void setup(){
  size(500, 500);
  background(255);
  noSmooth();
}

void draw(){
  background(255);
  // If the mouse is pressed it uses my function //
  if(mousePressed){
      stroke(255, 0, 0);
      drawLine(250, 250, mouseX, mouseY);
  }
  else{
    stroke(0, 0, 255);
    line(250, 250, mouseX, mouseY);
  }
  
  stroke(255, 0, 0);
  drawLine(250, 100, 250, 0); // Up
  drawLine(250, 100, 250, 200); // Down
  drawLine(250, 100, 350, 100); // Right
  drawLine(250, 100, 150, 100); // Left
  
  // Top right quarter //
  drawLine(250, 100, 300, 0);
  drawLine(250, 100, 350, 0);
  drawLine(250, 100, 350, 50);

  // Bottom right quarter //
  drawLine(250, 100, 300, 200);
  drawLine(250, 100, 350, 200);
  drawLine(250, 100, 350, 150);

  // Botton left quarter //
  drawLine(250, 100, 200, 200);
  drawLine(250, 100, 150, 200);
  drawLine(250, 100, 150, 150);
  
  // Top left quarter //
  drawLine(250, 100, 200, 0);
  drawLine(250, 100, 150, 0);
  drawLine(250, 100, 150, 50);
}

void drawLine(float startX, float startY, float endX, float endY){

  float xLength = endX - startX;
  float yLength = endY - startY;
  
  float A = -yLength;
  float B = xLength;
  float C = startX * endY - endX * startY;
  
  int stepX = xLength >= 0 ? 1 : -1;
  int stepY = yLength >= 0 ? 1 : -1;

  xLength = abs(xLength);
  yLength = abs(yLength);
  
  int currentX = Math.round(startX);
  int currentY = Math.round(startY);
    
  boolean isShallow = xLength >= yLength;
  
  if (isShallow) {
    // If it doesn't have this it doesn't work //
    if(stepX == 1){
      drawLine(endX, endY, startX, startY);
      return;
    }
    endX = Math.round(endX);
    
    float midpointY = (stepY > 0) ? currentY + 0.5f : currentY - 0.5f;
    float k = A * (currentX + stepX) + B * midpointY + C;

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

    float midpointX = (stepX > 0) ? currentX + 0.5f : currentX - 0.5f;
    float k = A * midpointX + B * (currentY + stepY) + C;

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
  
  point(endX, endY);  // final point
}
