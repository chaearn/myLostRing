//JIGGY
PImage hand;
float PosX, PosY;
float Speed;
boolean TurnLeft;

//STARS
ArrayList<Ball> balls;
ArrayList<Icecream> icecreams;
int ballWidth = 48;
float Timer;
PImage fall;
PImage rings;
PImage BG;

//TEXT
int score;
int handX, handY;


void setup()
{
  smooth(100000);
  size(1000, 600);
  hand = loadImage("hand.png");
  fall = loadImage("ring.png");
  rings = loadImage("ring.png");
  BG = loadImage("bg.png");

  //Stars
  balls = new ArrayList<Ball>();
  icecreams = new ArrayList<Icecream>();
  
  

  //Starting Point
  PosX = width/2;
  PosY = height-380;
  Speed = 10;

  handX = hand.width;
  handY = hand.height;
}



void draw()
{
  background(255);
  
  noStroke();
  //fill(0, 255, 0);
  //rect(0, height - 150, width, 150);
  tint(255,255,255);
  image(BG,0,0,width,height);

  JiggyDraw();
  JiggyMove();

  StarDraw();
  StarUpdate();
  
  IceDraw();
  IceUpdate();

  Collision();
  ScoreBoard();

  Stacker();
  

}

void IceDraw()
{
    
}

void IceUpdate()
{
    for (int i = icecreams.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Icecream icecream = icecreams.get(i);
    icecream.move();
    icecream.display();
    
    //int a = (TurnLeft)?-1:1;
    
    icecream.x = PosX + (50)-17 + 35;
    icecream.y = PosY - (i*10)+150;
    //if (icecream.finished()) {
    //  // Items can be deleted with remove()
    //  balls.remove(i);
    //}
  }
}

void Stacker()
{

}

void ScoreBoard()
{
  fill(255);
  textSize(24);
  text(score, 50, 50);
}

void Collision()
{

  for (int i = 0; i < balls.size(); i++)
  {
    Ball ball = balls.get(i);
    if (ball.x + ball.Star.width > PosX &&
      ball.x < PosX + hand.width &&
      ball.y + ball.Star.height > PosY &&
      ball.y < PosY + hand.height)
    {
      score += 1;
      icecreams.add(new Icecream(0,0,0));
      balls.remove(i);
    }
  }
}

void JiggyDraw()
{
  //if (TurnLeft)
  //{
  //  pushMatrix();
  //  scale(-1.0, 1.0);
  //  image(hand, -PosX-hand.width, PosY);
  //  popMatrix();
  //} else
  //{
    image(hand, PosX, PosY);
    //rect(PosX,PosY,Jiggy.width,Jiggy.height);
  //}
  //hand.resize(handX/2, handY/2);
}

void JiggyMove()
{
  if (keyPressed == true)
  {
    if (key == CODED)
    {
      if (keyCode == LEFT) 
      {
        if (PosX >= 0)
        {
          PosX -= Speed;
          TurnLeft = true;
        }
      }
      if (keyCode == RIGHT)
      {
        if (PosX <= width - hand.width)
        {
          PosX += Speed;
          TurnLeft = false;
        }
      }
    }
  }
}

void StarDraw()
{
  Timer++;
  if (Timer % 60 == 0)
  {
    balls.add(new Ball(random(0, width), 0, ballWidth));
  }
}

void StarUpdate()
{
  for (int i = balls.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if (ball.finished()) {
      // Items can be deleted with remove()
      balls.remove(i);
    }
  }
}