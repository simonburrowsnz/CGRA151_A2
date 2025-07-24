

void setup(){
  size(500, 500);
  background(255);
  noSmooth();
  
  fill(255, 0, 0);
  drawLine(250, 100, 250, 0);
  drawLine(250, 100, 300, 0);
  drawLine(250, 100, 350, 0);
  drawLine(250, 100, 350, 100);
  
  drawMidpointLine(250, 100, 250, 0);
  drawMidpointLine(250, 100, 300, 0);
  drawMidpointLine(250, 100, 350, 0);
  drawMidpointLine(250, 100, 350, 50);
  drawMidpointLine(250, 100, 350, 100);
  
  drawMidpointLine(250, 100, 300, 200);
  drawMidpointLine(250, 100, 350, 200);
  drawMidpointLine(250, 100, 350, 150);
  drawMidpointLine(250, 100, 250, 200);

  drawMidpointLine(250, 100, 200, 200);
  drawMidpointLine(250, 100, 150, 200);
  drawMidpointLine(250, 100, 150, 150);
  drawMidpointLine(250, 100, 150, 100);
  
  drawMidpointLine(250, 100, 200, 0);
  drawMidpointLine(250, 100, 150, 0);
  drawMidpointLine(250, 100, 150, 50);
  
  //fill(0, 0, 255);
  //line(200, 200, 100, 100);
  //line(250, 100, 250, 0);
  //line(250, 100, 350, 0);
  //line(250, 100, 350, 100);
}

void drawLine(float startX, float startY, float endX, float endY){
  
  float currentX = startX;
  float currentY = startY;
  
  float a = startY - endY;
  float b = endX - startX;
  float c = startX * endY - endX * startY;
  
  float xLength = endX - startX;
  float yLength = endY - startY;
  
  if(xLength >= yLength){
    for(float x = startX; x < endX; x++){
      float k = a*(x + 1) + b*(currentY + 1/2) + c;

      point(x, currentY);
      
      if(k<0){
        currentY++;
        point(x, currentY);
      }
    }
  }
  else{
    for(float y = startY; y < endY; y++){
      float k = a*(currentX + 1) + b*(y + 1/2) + c;
      
      point(currentX, y);
      
      if(k>0){
        currentX++;
        point(currentX, y);
      }
    }
  }
}

void drawMidpointLine(float startX, float startY, float endX, float endY){
  drawLine(startX, startY, endX, endY);
}
