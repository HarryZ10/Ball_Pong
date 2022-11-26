public boolean isBallCollidingWithRect(int x, int y, int w, int h)
{
  bool collided = false;
  float closestX = max(x, min(ball.getX(), x + w));
  float closestY = max(y, min(ball.getY(), y + h));

  float distX = ball.getX() - closestX;
  float distY = ball.getY() - closestY;

  float distXSquared = distX * distX;
  float distYSquared = distY * distY;
  float radiusSquared = BALL_RADIUS * BALL_RADIUS;

  if ((distXSquared + distYSquared) < radiusSquared)
  {
    collided = true;
  }

  return collided;
}
s