float ballX = 50;
float ballY = 50;
float ballSize = 25;

float xVelocity = 5;
float yVelocity = 0;
float gravity = 1;

rectangle bat;
float batX = 0;
float batY = 0;
float batWidth = 30;
float batHeight = 50;

float batVelocityX = 0;
float batVelocityY = 0;

ArrayList<rectangle> rectangles = new ArrayList<rectangle>();

void setup(){
  size(500, 500);
  background(255);
  frameRate(60);
  
  bat = new rectangle(0, 0, 30, 50, true);
  
  for(int i = 0; i < 3; i++){
    rectangles.add(new rectangle(random(0, 450), random(0, 450), random(10, 50), random(10, 50), false));
  }
}

void draw(){  
  
  bat.batCalculations();
  
  yVelocity += gravity;
  
  ballX += xVelocity;
  ballY += yVelocity;
  
  if(xVelocity > 25){
    xVelocity = 15;
  }
  if(yVelocity > 25){
    yVelocity = 25;
  }
  
  if(ballX < 0+(ballSize/2)){
    ballX = (ballSize/2);
    xVelocity *= -1;
  }
  else if(ballX > width-(ballSize/2)){
    ballX = width-(ballSize/2);
    xVelocity *= -1;
  }
  if(ballY < 0+(ballSize/2)){
    ballY = (ballSize/2);
    yVelocity *= -1;
  }
  else if(ballY > height-(ballSize/2)){
    ballY = height-(ballSize/2);
    yVelocity *= -1;
  }
  
  bat.collideWithRect();
  
  for(rectangle rects: rectangles){
    rects.collideWithRect();
  }
  
    
  background(255);
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballSize, ballSize);
  
  bat.renderRect();
  
  for(rectangle rects: rectangles){
    rects.renderRect();
  }
}

class rectangle{
  
  float rectX = 0;
  float rectY = 0;
  float rectWidth = 30;
  float rectHeight = 50;
  
  float rectVelocityX = 0;
  float rectVelocityY = 0;
  
  int hits = 0;
  
  boolean isBat;
  
  rectangle(float rX, float rY, float rW, float rH, boolean isBat){
    this.rectX = rX;
    this.rectY = rY;
    this.rectWidth = rW;
    this.rectHeight = rH;
    this.isBat = isBat;
  }
  
  void collideWithRect(){
    if(ballY > rectY && ballY < rectY+rectHeight && ballX > rectX-(ballSize/2) && ballX < rectX+rectWidth+(ballSize/2)){
      xVelocity += rectVelocityX;
      xVelocity *= -1;
      if(rectVelocityX < 0){
        ballX = rectX+rectWidth+(ballSize/2);
      }
      else if(rectVelocityX > 0){
        ballX = rectX-(ballSize/2);
      }
    }
    
    if(ballX > rectX && ballX < rectX+rectWidth && ballY > rectY-(ballSize/2) && ballY < rectY+rectHeight+(ballSize/2)){
      yVelocity += rectVelocityY;
      yVelocity *= -1;
      
      if(rectVelocityY < 0 && abs(rectVelocityY) > abs(yVelocity)){
        ballY = rectY+rectHeight+(ballSize/2);
      }
      else if(rectVelocityY > 0 && abs(rectVelocityY) > abs(yVelocity)){
        ballY = rectY-(ballSize/2);
      }
    }
  }
  
  void renderRect(){
    switch(hits){
      case 0:
        fill(0, 255, 0);
        break;
      case 1:
        fill(255, 255, 0);
        break;
      case 2:
        fill(255, 0, 0);
        break;
      case 3:
        rectangles.remove(this);
        break;
       default:
         fill(0);
    }
    if(isBat){
      fill(0, 0, 255);
    }
    rect(rectX, rectY, rectWidth, rectHeight);
  }
  
  void batCalculations(){
    if(!isBat){
      return;
    }
    rectVelocityX = rectX - mouseX;
    rectVelocityY = rectY - mouseY;
    
    rectX = mouseX;
    rectY = mouseY;
  }
}
