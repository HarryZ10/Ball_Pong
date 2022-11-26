/*
TO DO LIST:

         WHAT IS IT?                         IS IT POLISHED?

- PAUSE FEATURE/KEY RELEASED                       no
- 

*/
//import processing.sound.*;

public final int BALL_RADIUS = 8;
public final int BALL_DIAMETER = BALL_RADIUS * 2;
public final int PADDLE_WIDTH = 100;
public final int PADDLE_HEIGHT = 10;
public final int BRICK_WIDTH = 45;
public final int BRICK_HEIGHT = 20;

public int paddleX;
public int paddleY;

PImage bg;

//SoundFile lessLives;
//SoundFile breakingBricks;
//SoundFile backgroundMusic;
//SoundFile powerUp;

private Ball ball;

public Brick[] redBricks = new Brick[10];
public Brick[] orangeBricks = new Brick[10];
public Brick[] yellowBricks = new Brick[10];
public Brick[] greenBricks = new Brick[10];
public Brick[] blueBricks = new Brick[10];

public boolean hasGameStarted = false;
public boolean isGameOver = false;
public int bricksBroken = 0;
public int score = 0;
public int lives = 3;
public int y = 25;

public boolean within;
public boolean done;
public boolean run = true;

public void setup()
{
  size(480, 480);
  pixelDensity(2);
  ball = new Ball(width / 2, height - PADDLE_HEIGHT - BALL_RADIUS);
  
  //lessLives = new SoundFile(this, "banana.mp3");
  //breakingBricks = new SoundFile(this, "dryfiregun.mp3");
  //backgroundMusic = new SoundFile(this, "darude.mp3");
  //powerUp = new SoundFile(this, "powerup.wav");
  
  //backgroundMusic.amp(0.4);
  //backgroundMusic.play();
  
  bg = loadImage("bg.jpg");

  paddleX = width / 2 - PADDLE_WIDTH / 2;
  paddleY = height - PADDLE_HEIGHT;

//Creating the brick objects
  for (int i = 0; i < redBricks.length; i++) { 
    Brick red = new Brick(49 * i, 0, color(255, 0, 0)); 
    redBricks[i] = red;
  } 
  for (int i = 0; i < orangeBricks.length; i++) { 
    Brick orange = new Brick(49 * i, y, color(255, 140, 0)); 
    orangeBricks[i] = orange;
  }
  for (int i = 0; i < yellowBricks.length; i++) { 
    Brick yellow = new Brick(49 * i, y*2, color(255, 255, 0)); 
    yellowBricks[i] = yellow;
  } 
  for (int i = 0; i < greenBricks.length; i++) { 
    Brick green = new Brick(49 * i, y*3, color(50, 205, 50)); 
    greenBricks[i] = green;
  } 
  for (int i = 0; i < blueBricks.length; i++) { 
    Brick blue = new Brick(49 * i, y*4, color(0, 0, 255)); 
    blueBricks[i] = blue;
  } 
}

public void draw()
{
  if (!isGameOver && run == true)
  {
    background(0); 
    //image(bg, 0, 0);

    // Draw the ball.
    ball.drawBall();

    // Draw the paddle.
    fill(165, 42, 42);
    rect(paddleX, paddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
    
  }
  
    //Checks if ball is out of bonds
    isOutOfBounds(); //We know that instead of calling these 3 methods, we can check by if statements and then write the body of code here.
    
    //Checks if ball hits the side
    didHitSide();
    
    //Checks if ball hits the ceiling
    didHitTop();

    //breakingBricks.amp(0.5);
    //Draws the bricks: red, orange, yellow, green, and blue
    for (int i = 0; i < redBricks.length; i++) { 
      if  (redBricks[i] != null) {
        Brick myBrick = redBricks[i]; 
        myBrick.drawBrick();
        //Checks if it is colliding with the ball
        if(redBricks[i].isCollidingWithBall()){
          redBricks[i] = null; //removes the brick
          //breakingBricks.play(); //plays sound effects with collided and broke the brick
          bricksBroken++; //adds 1 to the brick count
          score += 2;
          ball.reverseSpeedY(); //go back the other direction
        }
      } //comments from line 102 - 115 are the same for below code
    } 
    for (int i = 0; i < orangeBricks.length; i++) { 
      if  (orangeBricks[i] != null) {
        Brick myBrick = orangeBricks[i]; 
        myBrick.drawBrick();
        if(orangeBricks[i].isCollidingWithBall()){
          orangeBricks[i] = null;
          //breakingBricks.play();
          bricksBroken++;
          score += 2;
          ball.reverseSpeedY();
        }
      }
    } 
    for (int i = 0; i < yellowBricks.length; i++) { 
      if  (yellowBricks[i] != null) {
        Brick myBrick = yellowBricks[i]; 
        myBrick.drawBrick();
        if(yellowBricks[i].isCollidingWithBall()){
          yellowBricks[i] = null;
          //breakingBricks.play();
          bricksBroken++;
          score += 2;
          ball.reverseSpeedY();
        }
      }
    } 
    for (int i = 0; i < greenBricks.length; i++) { 
      if  (greenBricks[i] != null) {
        Brick myBrick = greenBricks[i]; 
        myBrick.drawBrick();
        if(greenBricks[i].isCollidingWithBall()){
          greenBricks[i] = null;
          //breakingBricks.play();
          bricksBroken++;
          score += 2;
          ball.reverseSpeedY();
        }
      }

    } 
    for (int i = 0; i < blueBricks.length; i++) { 
      if  (blueBricks[i] != null) {
        Brick myBrick = blueBricks[i]; 
        myBrick.drawBrick();
        if(blueBricks[i].isCollidingWithBall()){
          blueBricks[i] = null;
          //breakingBricks.play();
          bricksBroken++;
          score += 2;
          ball.reverseSpeedY();
        }
      }

    } 

    if(isBallCollidingWithPaddle()){
      ball.reverseSpeedY();
    }
    
    if(score == 100){
      gameOver(!areAllBricksBroken());
    }
    
    if(!within && !done && score == 50){
      //println("executed");
      done = true;
      lives += 2;
      //powerUp.amp(0.4);
      //powerUp.play();
      text("Lives: " + lives, 20, 220);
    }
      textSize(30);
      text("Score: " + score, 20, 180);
      text("Lives: " + lives, 20, 220);
}

public void mouseMoved(MouseEvent event)
{
  int x = event.getX();
  paddleX = x - PADDLE_WIDTH / 2;

  if (!hasGameStarted)
  {
    ball.setX(x); //follows the mouse event
  }
}

public void mouseReleased(MouseEvent event)
{
  if (!hasGameStarted)
  {
    ball.setSpeedX(5);
    ball.setSpeedY(-3);
    hasGameStarted = true;
  }
}

public boolean didHitSide()
{
  if(ball.getX() >= 480 || ball.getX() <= 5){
    ball.reverseSpeedX();
    return true;
  }
  return false;
}

public boolean didHitTop()
{
  if(ball.getY() <= 1){
    ball.reverseSpeedY();
    return true;
  }
  return false;
}

public boolean isOutOfBounds()
{
  if(ball.getY() == 480){
    if(lives == 0){
      gameOver(false);
    } else {
      lives--;
      lessLives.play();
      ball.setX(width / 2);
      ball.setY(height - PADDLE_HEIGHT - BALL_RADIUS);
      ball.reverseSpeedY();
    }
    return true; 
  }
  return false;
}

public boolean isBallCollidingWithPaddle()
{
  return isBallCollidingWithRect(paddleX, paddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
}

public boolean areAllBricksBroken()
{
  return false;
}

public void gameOver(boolean didWin)
{
  backgroundMusic.stop();
  hasGameStarted = false;
  isGameOver = true;
  if(didWin == true){
    fill(255);
    textSize(20);
    text("YOU WIN!! Press X to RESTART", 50, 300);
  }
  else if(didWin == false){
    fill(255);
    textSize(20);
    text("YOU LOST!! Press X to RESTART", 50, 300);
  } 
}

void stopAllMusic(){
  backgroundMusic.stop();
}

void keyReleased(){
  if(run == true){
    if(key == 'x' || key == 'X'){
      hasGameStarted = false;
      stopAllMusic();
      restartGame();
    }
  }
  
  if(!isGameOver){
    if(key == 'p'){
      run = !run;
      if(run == true){
        fill(211, 211, 211, 255);
        rect(0, 0, 480, 480);
        backgroundMusic.play();
      }
      if(run == false){
        fill(211, 211, 211, 100);
        rect(0, 0, 480, 480);
        backgroundMusic.pause();
        fill(0);
        text("Press P to unPause!", 130, 300);
      }
    }
  }
}

public void restartGame()
{
  isGameOver = false;
  bricksBroken = 0;  
  score = 0;
  lives = 3;
  done = false;
  setup();
  draw();
  mouseReleased();
  mouseMoved();
}
