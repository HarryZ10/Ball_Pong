public class Ball
{
  private float x;
  private float y;
  private float speedX;
  private float speedY;

  public Ball(int ix, int iy)
  {
    x = ix;
    y = iy;
  }

  public float getX()
  {
    return x; 
  }
  
  public float getY()
  {
    return y;
  }

  public void setX(int ix)
  {
    x = ix;
  }

  public void setY(int iy)
  {
    y = iy;
  }

  public void reverseSpeedX()
  {
    speedX = -speedX;
  }

  public void reverseSpeedY()
  {
    speedY = -speedY;
  }

  public void setSpeedX(int isx)
  {
    speedX = isx;
  }

  public void setSpeedY(int isy)
  {
    speedY = isy;
  }

  public void drawBall()
  {
    x += speedX;
    y += speedY;

    fill(30, 144, 255);
    noStroke();
    ellipse(x, y, BALL_DIAMETER, BALL_DIAMETER);
  }
}
