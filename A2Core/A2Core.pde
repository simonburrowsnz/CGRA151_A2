float ballX = 50;
float ballY = 50;
float ballSize = 25;

float xVelocity = 5;
float yVelocity = 0;
float gravity = 1;

float batX = 0;
float batY = 0;
float batWidth = 30;
float batHeight = 50;

float batVelocityX = 0;
float batVelocityY = 0;

void setup(){
  size(500, 500);
  background(255);
  frameRate(60);
}

void draw(){  
  
  batVelocityX = batX - mouseX;
  batVelocityY = batY - mouseY;
  
  batX = mouseX;
  batY = mouseY;
  
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
  
  // Bat colitsion
  if(ballY > batY && ballY < batY+batHeight && ballX > batX-(ballSize/2) && ballX < batX+batWidth+(ballSize/2)){
      xVelocity += batVelocityX;
      xVelocity *= -1;
      if(batVelocityX < 0){
        ballX = batX+batWidth+(ballSize/2);
      }
      else if(batVelocityX > 0){
        ballX = batX-(ballSize/2);
      }
  }
  
  if(ballX > batX && ballX < batX+batWidth && ballY > batY-(ballSize/2) && ballY < batY+batHeight+(ballSize/2)){
      yVelocity += batVelocityY;
      yVelocity *= -1;
      
      if(batVelocityY < 0 && abs(batVelocityY) > abs(yVelocity)){
        ballY = batY+batHeight+(ballSize/2);
      }
      else if(batVelocityY > 0 && abs(batVelocityY) > abs(yVelocity)){
        ballY = batY-(ballSize/2);
      }
  }
  
    
  background(255);
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballSize, ballSize);
  
  fill(0, 0, 255);
  rect(batX, batY, batWidth, batHeight);
}
