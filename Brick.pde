public class Brick
{
  private int x; 
  private int y;
  private int w = BRICK_WIDTH;
  private int h = BRICK_HEIGHT;
  private int c;

  public Brick(int initX, int initY, int initColor)
  {
    x = initX;
    y = initY;
    c = initColor;
  }

  public int getX()
  {
    return x;
  }

  public int getY()
  {
    return y;
  }

  public boolean isCollidingWithBall()
  {
    return isBallCollidingWithRect(x, y, w, h);
  }

  public void drawBrick()
  {
    fill(c);
    noStroke();
    rect(x, y, w, h);
  }
}
