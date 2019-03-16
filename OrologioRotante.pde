
PFont mono;

Clock clock;
void setup() {
  size (600, 600);
  //mono = loadFont("andalemo.ttf", 32);

  clock = new Clock(-200, 300, 400);
  clock.setup();
}


void draw() {
  background(200);
  stroke (0);
  noFill();

  clock.draw();
}

void push() {
  pushStyle();
  pushMatrix();
}

void pop() {
  popMatrix();
  popStyle();
}



class Clock {
  int x, y;
  int r;
  Corona hh, mm, ss;
  int h, m, s;
  Clock(int x_, int y_, int r_) {
    x= x_;
    y= y_;
    r=r_;
    h= hour();
    m= minute();
    s= second();
  }
  void setup() {
    h= hour();
    hh= new Corona(r, h, 24, 30);
    m= minute();
    mm= new Corona(r+50, m, 60, 20);
    s= second();
    ss= new Corona(r+90, s, 60, 17);
  }
  void draw() {
    if (h!= hour()) {
      h= hour();
      hh= new Corona(r, h, 24, 30);
    }
    if (m!=minute()) {
      m= minute();
      mm= new Corona(r+50, m, 60, 20);
    }
    if (s!= second()) {
      s= second();
      ss= new Corona(r+90, s, 60, 17);
    }
    translate(x, y);
    textAlign(CENTER, CENTER);
    //int h= hour();
    //int m= minute();
    //int s= second();


    //hh= new Corona(r, h, 24, 30);
   hh.draw();

    //mm= new Corona(r+50, m, 60, 20);
   mm.draw();

    //ss= new Corona(r+90, s, 60, 17);
    ss.draw();
  }
}


String pad(String t) {
  if (t.length()==1) {
    return "0"+t;
  } else
  {
    return t;
  }
}


class Corona {
  int time, d, div, tsize;
  int angle;
  
  Corona(int d_, int time_, int div_, int tsize_) {
    time=time_; 
    d=d_;
    div=div_;
    tsize=tsize_;
    //angle=0;
  }


  void draw() {
    angle+=TWO_PI/div;
    println(angle);
    fill(0);
    textSize(tsize);
    strokeWeight((int)tsize/5);

    push();
    rotate((time%div)*TWO_PI/div+angle);
    for (int i =0; i < div; i++) {
      //point(d, 0);
      if ((div-i)==(time%div)) {
        fill(255, 255, 0);
        strokeWeight((int)tsize/4);
        textSize((int)tsize*1.5);
        if (time>div) {
          text (pad(str((div-i)+div)), d, 0);
        } else {
          text (pad(str(div-i)), d, 0);
        }
      } else
      {
        fill(0);
        textSize(tsize);
        strokeWeight((int)tsize/5);

        if (time>div) {
          text (pad(str((div-i)+div)), d, 0);
        } else {
          text (pad(str(div-i)), d, 0);
        }
      }
      rotate(TWO_PI/div);
    }
    pop();
  }
}
