class Asteroid extends PVector {
  PVector  pPos;
  PVector  vel; 
  PVector  acc;
  float    mass;
  boolean  alive;

  Asteroid() {
    super();
    alive = true;
    pPos = new PVector();
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    mass = 100;
  }

  void changePosition(PVector pos) {
    set(pos);
    pPos.set(pos);
  }

  void update(Planet[] planet) {
    if (alive) {
      acc.set(0, 0, 0);

      for (int i = 0; i<planet.length;i++) {
        float ang = calcAngle(planet[i]);
        float g = 1;
        float force = (float)(g*(mass * planet[i].mass)/(Math.pow(dist(this, planet[i]), 2)));
        acc.add(-force/mass * cos(ang), force/mass * sin(ang), 0);
      }

      vel.add(acc);
      add(vel);
      checkEdges();
      checkCollision(planet);
    }
  }

  void checkEdges() {
    float frame = 20;
    if (x<-frame) {
      x=-frame;
      alive = false;
    }
    if (x>width+frame) {
      x=width+frame;
      alive = false;
    }
    if (y<-frame) {
      y=-frame;
      alive = false;
    }
    if (y>height+frame) {
      y = height+frame;
      alive = false;
    }
  }

  void checkCollision(Planet[] planet) {
    for (int i = 0;i<planet.length; i++) {
      float dis = dist(this, planet[i]);
      if (dis<sqrt(this.mass/PI)+sqrt(planet[i].mass/PI)) {
        alive=false;
      }
    }
  }

  void draw() {
    if(alive){
      line(x, y, pPos.x, pPos.y);
      pPos.set(x, y, 0);
    }
  }
  float calcAngle (PVector a) {
    return -(float)(Math.atan2(y-a.y, x-a.x ));
  }
}

