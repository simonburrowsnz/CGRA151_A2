// Is no gravity but can have it //
float GRAVITY = 0;

// Creates ball and bat //
Ball ball = new Ball(50, 150, 25);

Bat bat = new Bat(0, 0, 50, 30);

ArrayList<Rectangle> Rectangles = new ArrayList<Rectangle>();
ArrayList<Rectangle> RectanglesToRemove = new ArrayList<Rectangle>();

void setup() {
  size(500, 500);
  background(255);
  //frameRate(60);

  // Adds all the rectangles to the rentangles list //
  for (int y = 0; y < 3; y++) {
    for (int x = 0; x < 10; x++) {
      Rectangles.add(new Rectangle(x*50 + 10, y*40, 30, 20, 0));
    }
  }
}

void draw() {

  // Sets the bat's x&y to the mouse position //
  bat.batCalculations();

  // Draws all the objects //
  background(255);

  ball.drawBall();
  bat.renderRect();

  for (Rectangle rects : Rectangles) {
    rects.renderRect();
  }
  // Removes the rectangles that have been hit 3 times //
  for (Rectangle rects : RectanglesToRemove) {
    Rectangles.remove(rects);
  }

  // If there are no more rectangles you win //
  if (Rectangles.size() == 0) {
    background(255);
    fill(0);
    text("you win", height/2, width/2);
    noLoop();
    delay(1000);
    exit();
  }
}

// Class for ball //
class Ball {

  float ballX;
  float ballY;
  float ballSize;
  float ballRadius;

  float xVelocity = 5;
  float yVelocity = 5;

  Ball(float bX, float bY, float bW) {
    this.ballX = bX;
    this.ballY = bY;
    this.ballSize = bW;
    this.ballRadius = bW/2;
  }

  // Calculates the balls new position then moves it //
  void drawBall() {
    // Does gravity //
    yVelocity += GRAVITY;

    // Moves the ball //
    ballX += xVelocity;
    ballY += yVelocity;

    // Resctrics the x & y speed to 20 //
    if (xVelocity > 20) {
      xVelocity = 20;
    }
    if (yVelocity > 20) {
      yVelocity = 20;
    }

    // Wall collition //
    if (ballX < 0+ballRadius) {
      ballX = ballRadius;
      xVelocity *= -1;
    } 
    else if (ballX > width-ballRadius) {
      ballX = width-ballRadius;
      xVelocity *= -1;
    }
    if (ballY < 0+ballRadius) {
      ballY = ballRadius;
      yVelocity *= -1;
    } 
    // If the ball touches the bootom of the screen you loose //
    else if (ballY > height-ballRadius) {
      background(255);
      fill(0);
      text("you lose", height/2, width/2);
      noLoop();
      delay(1000);
      exit();
    }

    // Checks the collition with all the rectangles //
    for (Rectangle rect: Rectangles) {
      this.collideWithRectangle(rect);
    }
    // Checks the collition with the bat //
    this.collideWithRectangle(bat);
    
    fill(255, 0, 0);
    ellipse(ballX, ballY, ballSize, ballSize);
  }

  // Figures out what to do when colliding with a rectangle //
  void collideWithRectangle(Rectangle rect) {
    // Finds the closest point on the rectangle to the center of the ball //
    float closestX = constrain(ballX, rect.rectX, rect.rectX + rect.rectWidth);
    float closestY = constrain(ballY, rect.rectY, rect.rectY + rect.rectHeight);
  
    // Calculates the distance from the ball to the closest point //
    float distanceX = ballX - closestX;
    float distanceY = ballY - closestY;
    float distanceSquared = distanceX * distanceX + distanceY * distanceY;
  
    if (distanceSquared < ballRadius * ballRadius) {
      // Normalize the distance vector //
      float magnitude = sqrt(distanceSquared);
      float normX = (magnitude == 0) ? 0 : distanceX / magnitude;
      float normY = (magnitude == 0) ? 0 : distanceY / magnitude;
  
      // Pushes ball out of rectangle slightly //
      float overlap = ballRadius - magnitude;
      ballX += normX * overlap;
      ballY += normY * overlap;
  
      // Determine if it was a corner or edge hit //
      boolean hitVerticalEdge = closestX == rect.rectX || closestX == rect.rectX + rect.rectWidth;
      boolean hitHorizontalEdge = closestY == rect.rectY || closestY == rect.rectY + rect.rectHeight;
  
      // Reflect based on movement direction and point of impact //
      if (hitVerticalEdge && (ballX < rect.rectX && xVelocity > 0 || ballX > rect.rectX + rect.rectWidth && xVelocity < 0)) {
        xVelocity *= -1;
      }
  
      if (hitHorizontalEdge && (ballY < rect.rectY && yVelocity > 0 || ballY > rect.rectY + rect.rectHeight && yVelocity < 0)) {
        yVelocity *= -1;
      }

      rect.hits++;
    }
  }
}
class Rectangle {

  protected float rectX;
  protected float rectY;
  protected float rectWidth;
  protected float rectHeight;

  protected float rectVelocityX;
  protected float rectVelocityY;

  protected int hits = 0;

  Rectangle(float rX, float rY, float rW, float rH, int h) {
    this.rectX = rX;
    this.rectY = rY;
    this.rectWidth = rW;
    this.rectHeight = rH;
    this.hits = h;
  }

  // Draws the rectangle based of of how many times it's been hit, if it had been hit three times then it will remove it, if it's a bat then it will just draw it blue //
  void renderRect() {
    switch(hits) {
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
      RectanglesToRemove.add(this);
      break;
    default:
      fill(0, 0, 255);
    }
    rect(rectX, rectY, rectWidth, rectHeight);
  }
}

// Bat object
class Bat extends Rectangle {

  Bat(float rX, float rY, float rW, float rH) {
    super(rX, rY, rW, rH, 4);
  }

  // Sets the poistion of the bat to the mouse position //
  void batCalculations() {
    rectX = mouseX;
    rectY = mouseY;
  }
}
