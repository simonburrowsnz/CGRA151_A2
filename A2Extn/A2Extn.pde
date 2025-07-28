

void setup(){
  size(500, 500);
  background(255);
  noSmooth();
  
  //noLoop();
}

void draw(){
  fill(255, 0, 0);
  
  background(255);
  drawMidpointLine(250, 250, mouseX, mouseY);
  //drawLine(250, 100, 250, 0);
  //drawLine(250, 100, 300, 0);
  //drawLine(250, 100, 350, 0);
  //drawLine(250, 100, 350, 100);
  
  //drawMidpointLine(250, 100, 250, 0); // Up
  //drawMidpointLine(250, 100, 250, 200); // Down
  //drawMidpointLine(250, 100, 350, 100); // Right
  //drawMidpointLine(250, 100, 150, 100); // Left
  
  //drawMidpointLine(250, 100, 300, 0);
  //drawMidpointLine(250, 100, 350, 0);
  //drawMidpointLine(250, 100, 350, 50);
  
  //drawMidpointLine(250, 100, 300, 200);
  //drawMidpointLine(250, 100, 350, 200);
  //drawMidpointLine(250, 100, 350, 150);

  //drawMidpointLine(250, 100, 200, 200);
  //drawMidpointLine(250, 100, 150, 200);
  //drawMidpointLine(250, 100, 150, 150);
  
  //drawMidpointLine(250, 100, 200, 0);
  //drawMidpointLine(250, 100, 150, 0);
  //drawMidpointLine(250, 100, 150, 50);
  
  
  //fill(0, 0, 255);
  //line(200, 200, 100, 100);
  //line(250, 100, 250, 0);
  //line(250, 100, 350, 0);
  //line(250, 100, 350, 100);
}

void drawLine(float startX, float startY, float endX, float endY){

  float xLength = endX - startX;
  float yLength = endY - startY;
  
  float A = -yLength;
  float B = xLength;
  float C = startX * endY - endX * startY;
  
  int scaleX = xLength >= 0 ? 1 : -1;
  int scaleY = yLength >= 0 ? 1 : -1;

  xLength = abs(xLength);
  yLength = abs(yLength);
  
  int currentX = Math.round(startX);
  int currentY = Math.round(startY);
    
  boolean isShallow = xLength >= yLength;
  
  if (isShallow) {

    println(scaleX + "X, " + scaleY + "Y" + " not steep");
    endX = Math.round(endX);
    
    float midpointY = (scaleY > 0) ? currentY + 0.5f : currentY - 0.5f;
    float k = A * (currentX + scaleX) + B * midpointY + C;

    while (currentX != endX) {
      point(currentX, currentY);
      currentX += scaleX;

      if (scaleY * k > 0){
        currentY += scaleY;
        k += A * scaleX + B * scaleY;
      } else {
        k += A * scaleX;
      }
      midpointY = (scaleY > 0) ? currentY + 0.5f : currentY - 0.5f;
    }
  } else {
    // Steep slope: iterate over y
    println(scaleX + "X, " + scaleY + "Y" + " steep");
    endY = Math.round(endY);

    float midpointX = (scaleX > 0) ? currentX + 0.5f : currentX - 0.5f;
    float k = A * midpointX + B * (currentY + scaleY) + C;

    while (currentY != endY) {
      point(currentX, currentY);
      currentY += scaleY;

      if (scaleX * k > 0){    
        currentX += scaleX;
        k += A * scaleX + B * scaleY;
      } else {
        k += B * scaleY;
      }
      
      midpointX = (scaleX > 0) ? currentX + 0.5f : currentX - 0.5f;
    }
  }
  
  point(endX, endY);  // final point
}

void drawMidpointLine(float startX, float startY, float endX, float endY){
  drawLine(startX, startY, endX, endY);
}


void AIdrawLine(float startX, float startY, float endX, float endY){
  int x0 = round(startX);
  int y0 = round(startY);
  int x1 = round(endX);
  int y1 = round(endY);

  int dx = abs(x1 - x0);
  int dy = abs(y1 - y0);

  int stepX = x0 < x1 ? 1 : -1;
  int stepY = y0 < y1 ? 1 : -1;

  int err = dx - dy;

  while (true) {
    point(x0, y0);

    if (x0 == x1 && y0 == y1) break;

    int e2 = 2 * err;

    if (e2 > -dy) {
      err -= dy;
      x0 += stepX;
    }

    if (e2 < dx) {
      err += dx;
      y0 += stepY;
    }
  }
}
