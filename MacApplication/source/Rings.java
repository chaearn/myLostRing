import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Rings extends PApplet {

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


public void setup()
{
  
  
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



public void draw()
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

public void IceDraw()
{
    
}

public void IceUpdate()
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

public void Stacker()
{

}

public void ScoreBoard()
{
  fill(255);
  textSize(24);
  text(score, 50, 50);
}

public void Collision()
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

public void JiggyDraw()
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

public void JiggyMove()
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

public void StarDraw()
{
  Timer++;
  if (Timer % 60 == 0)
  {
    balls.add(new Ball(random(0, width), 0, ballWidth));
  }
}

public void StarUpdate()
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
class Ball {

  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  PImage Star;
  float r,g,b;

  Ball(float tempX, float tempY, float tempW ) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1f;
    Star = fall;
    
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
  }

  public void move() 
  {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
  }

  public boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }

  public void display() {
    // Display the circle
    fill(0, life);
    //stroke(0,life);
    //tint(r,g,b);
    image(Star, x, y);
    //Star.resize(100, 100);
    //ellipse(x,y,w,w);
  }
}  
class Icecream {
  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 255;
  PImage IMG;
  float r,g,b;
  
  Icecream(float tempX, float tempY, float tempW ) {
    x = tempX;
    y = tempY;
    w = tempW;
    
    speed = 0;
    gravity = 0.1f;
    IMG = rings;
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
  }
   
    public void move() {
    // Add gravity to speed
    //speed = speed + gravity;
    // Add speed to y location
    
    // If square reaches the bottom
  }
  
  //boolean finished() {
  //  // Icecreams fade out
  //  life--;
  //  if (life < 0) {
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}
  
  public void display() 
  {
    // Display the circle
    fill(0,life);
    //stroke(0,life);
    //tint(r,g,b);
    image(IMG,x,y);
    //IMG.resize(120, 100);
    //ellipse(x,y,w,w);
  }
}  
  public void settings() {  size(1000, 600);  smooth(100000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Rings" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
