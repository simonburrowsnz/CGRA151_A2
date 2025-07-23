float ballX = 50;
float ballY = 150;
float ballSize = 25;
float ballRadius = ballSize/2;

float xVelocity = 1;
float yVelocity = 0;
float GRAVITY = 0.2;

rectangle bat;

ArrayList<rectangle> rectangles = new ArrayList<rectangle>();
ArrayList<rectangle> rectanglesToRemove = new ArrayList<rectangle>();

void setup(){
  size(500, 500);
  background(255);
  frameRate(60);
  
  bat = new rectangle(0, 0, 50, 30, true);

  for(int y = 0; y < 3; y++){
    for(int x = 0; x < 10; x++){
      rectangles.add(new rectangle(x*50 + 10, y*40, 30, 20, false));
    }
  }  
}

void draw(){  
  
  bat.batCalculations();
  
  yVelocity += GRAVITY;
  
  ballX += xVelocity;
  ballY += yVelocity;
  
  if(xVelocity > 20){
    xVelocity = 20;
  }
  if(yVelocity > 20){
    yVelocity = 20;
  }
  
  if(ballX < 0+ballRadius){
    ballX = ballRadius;
    xVelocity *= -1;
  }
  else if(ballX > width-ballRadius){
    ballX = width-ballRadius;
    xVelocity *= -1;
  }
  if(ballY < 0+ballRadius){
    ballY = ballRadius;
    yVelocity *= -1;
  }
  else if(ballY > height-ballRadius){
    ballY = height-ballRadius;
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
  for(rectangle rects: rectanglesToRemove){
    rectangles.remove(rects);
  }
  
  if(rectangles.size() == 0){
    background(255);
    noLoop();
    fill(0);
    text("you win", height/2, width/2);
  }
}

class rectangle{
  
  float rectX;
  float rectY;
  float rectWidth;
  float rectHeight;
  
  float rectVelocityX;
  float rectVelocityY;
  
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
    
    if(isNearX() && isNearY()){
      
      float reflectX = rectX;
      float reflectY = rectY;
      
      if(ballY-(rectY+rectHeight/2) < 0){
        reflectY += rectHeight;
      }
      if(ballX-(rectX+rectWidth/2) < 0){
        reflectX += rectWidth;
      }
      
      float reflexAngle = atan2((ballY-reflectY) , (ballX-reflectX));
      
      float speed = sqrt(sq(xVelocity) + sq(yVelocity));
      
      PVector reflectedVector = PVector.fromAngle(reflexAngle);
      
      reflectedVector.setMag(speed);
      
      xVelocity = reflectedVector.x;
      yVelocity = reflectedVector.y;
      
    }
    else if(isWithinY() && isNearX()){
      xVelocity += rectVelocityX;
      xVelocity *= -1;
      if(rectVelocityX < 0 && abs(rectVelocityX) > abs(xVelocity)){
        ballX = rectX+rectWidth+ballRadius;
      }
      else if(rectVelocityX > 0 && abs(rectVelocityX) > abs(xVelocity)){
        ballX = rectX-ballRadius;
      }
    }
    else if(isWithinX() && isNearY()){
      yVelocity += rectVelocityY;
      yVelocity *= -1;
      
      if(rectVelocityY < 0 && abs(rectVelocityY) > abs(yVelocity)){
        ballY = rectY+rectHeight+ballRadius;
      }
      else if(rectVelocityY > 0 && abs(rectVelocityY) > abs(yVelocity)){
        ballY = rectY-ballRadius;
      }
    }
    else{
      return;
    }
    hits++;
  }
  
  boolean isWithinX(){
    return ballX > rectX && ballX < rectX+rectWidth;
  }
  
  boolean isWithinY(){
    return ballY > rectY && ballY < rectY+rectHeight;
  }
  
  boolean isNearX(){
    return ballX > rectX-ballRadius && ballX < rectX+rectWidth+ballRadius && !isWithinX();
  }
  
  boolean isNearY(){
    return ballY > rectY-ballRadius && ballY < rectY+rectHeight+ballRadius && !isWithinY();
  }
  
  void renderRect(){
    if(isBat){
      fill(0, 0, 255);
      rect(rectX, rectY, rectWidth, rectHeight);
      return;
    }
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
        rectanglesToRemove.add(this);
        break;
       default:
         fill(0);
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
