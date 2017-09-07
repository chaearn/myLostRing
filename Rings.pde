//Hand
PImage hand;
float PosX, PosY;
float Speed;
boolean TurnLeft;

//inFinger
ArrayList<Fall> Falls;  
ArrayList<Ring> Rings;
int Width = 48;
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

  //inFingers
  Falls = new ArrayList<Fall>();
  Rings = new ArrayList<Ring>();



  //inFingerting Point
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
  tint(255, 255, 255);
  image(BG, 0, 0, width, height);

  handDraw();
  handMove();

  fallDraw();
  fallUpdate();

  //ringDraw();
  ringUpdate();

  Collision();
  ScoreBoard();

  //Stacker();
}

//void ringDraw()
//{

//}

void ringUpdate()
{
  for (int i = Rings.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Ring Ring = Rings.get(i);
    Ring.move();
    Ring.display();

    //int a = (TurnLeft)?-1:1;

    Ring.x = PosX + (50)-17 + 35;
    Ring.y = PosY - (i*10)+150;
    //if (Ring.finished()) {
    //  // Items can be deleted with remove()
    //  Falls.remove(i);
    //}
  }
}

//void Stacker()
//{

//}

void ScoreBoard()
{
  fill(255);
  textSize(24);
  text(score, 50, 50);
}

void Collision()
{

  for (int i = 0; i < Falls.size(); i++)
  {
    Fall Fall = Falls.get(i);
    if (Fall.x + Fall.inFinger.width > PosX &&
      Fall.x < PosX + hand.width &&
      Fall.y + Fall.inFinger.height > PosY &&
      Fall.y < PosY + hand.height)
    {
      score += 1;
      Rings.add(new Ring(0, 0, 0));
      Falls.remove(i);
    }
  }
}

void handDraw()
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

void handMove()
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

void fallDraw()
{
  Timer++;
  if (Timer % 60 == 0)
  {
    Falls.add(new Fall(random(0, width), 0, Width));
  }
}

void fallUpdate()
{
  for (int i = Falls.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Fall Fall = Falls.get(i);
    Fall.move();
    Fall.display();
    if (Fall.finished()) {
      // Items can be deleted with remove()
      Falls.remove(i);
    }
  }
}