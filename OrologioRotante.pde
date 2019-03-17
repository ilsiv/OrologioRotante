//Inspiration from https://www.openprocessing.org/sketch/441988 //<>//
//***

PFont mono;

Clock clock;
void setup() {
  size (600, 600);
  //mono = loadFont("andalemo.ttf", 32);

  clock = new Clock(00, 300, 200);
  clock.setup();
  // frameRate(10);
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


String pad(String t) {
  if (t.equals("60")) {
    t="00";
  }

  if (t.length()==1) {
    return "0"+t;
    } else
    {
      return t;
    }
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
    hh= new Corona(r, h, 24, 30);
    mm= new Corona(r+50, m, 60, 20);
    ss= new Corona(r+90, s, true, 60, 17);
  }

  void setup() {
    textAlign(CENTER, CENTER);
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
      ss= new Corona(r+90, s, true, 60, 17);
    }
    translate(x, y);

    hh.draw();
    mm.draw();
    ss.draw();
  }
}



class Corona {
  int time, d, div, tsize;
  boolean mill;
  float angle;
  int millprev;
  int milli = 0, diff = 0;

  Corona(int d_, int time_, int div_, int tsize_) {
    time=time_;
    d=d_;
    div=div_;
    tsize=tsize_;
    angle=0;
  }

  Corona(int d_, int time_, boolean mill_, int div_, int tsize_) {
    time=time_;
    mill=mill_;
    d=d_;
    div=div_;
    tsize=tsize_;
    angle=0;
    millprev=millis();
  }


  void draw() {
    milli=millis()%1000;
    diff=(milli-millprev);
    if (mill) {
      if (diff>=0) {
        angle+=map(diff, 0, 1000, 0, (TWO_PI/div));
      }
      millprev= milli;
    }
    fill(0);
    textSize(tsize);
    strokeWeight((int)tsize/5);

    push();
    // rotate(angle);
    rotate((time%div)*TWO_PI/div+angle);
    for (int i =0; i < div; i++) {
      //point(d, 0);
      int j= (div-i);
      if (j==60) {
        j=0;
      }
      if (j==(time%div)) {
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
