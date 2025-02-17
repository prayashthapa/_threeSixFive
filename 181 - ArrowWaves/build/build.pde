PVector [] sineVals;
int n;
int margin = 25; 

void setup() {
  size(900, 900);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  n = width;
  sineVals = new PVector[n];
}

void draw() {
  background(225, 100, 25);
  noStroke();
  fill(225, 70, 100);
  int margin = 25 + int((height / 4.0) * (0.5 * (1 + sin(PI / 2 + radians(frameCount * 0.3)))));
  float off = radians(frameCount);
  float off2 = radians(frameCount * 0.7);
  float amp = 200;
  for (int px = 0; px < n; px++) {
    float cx = map(px, 0, n, 0, 2 * PI);
    float cy = 0.5 * (cos(1.7 * cx + off2) + sin(2 * cx + off));
    float py = map(cy, -1, 1, height / 2 - amp, height / 2 + amp);
    sineVals[px] = new PVector(map(px, 0, width, -margin, width + margin), py);
  }
  
  int levels = 30;
  for (int level = 0; level <= levels; level++) {
    int indexOff = int(level * 3 + frameCount * 1.5) % 20;
    fill(225 + 25.0 * level / levels, 20 + 50.0 * level / levels, 100);
    for (int i = indexOff; i < sineVals.length - indexOff - 1; i += 20) {
      float lerpValue = abs(1.0 * level - levels / 2) / (levels / 2);
      boolean above = level < levels / 2;
      PVector p = sineVals[i];
      p = PVector.lerp(p, above ? new PVector(p.x, margin) : new PVector(p.x, height - margin), lerpValue);
      PVector p2 = sineVals[i + 1];
      p2 = PVector.lerp(p2, above ? new PVector(p2.x, margin) : new PVector(p2.x, height - margin), lerpValue);
      PVector diff = p2.copy().sub(p).normalize();
      PVector n = new PVector(-diff.y, diff.x);
      PVector a = p.copy().add(diff.mult(15));
      PVector b = p.copy().add(n.copy().mult(5));
      PVector c = p.copy().sub(n.copy().mult(5));
      triangle(a.x, a.y, b.x, b.y, c.x, c.y);
    }
  }
  
  // image(pg, 0, 0, width, height);
  // if (frameCount % 60 == 0) {
  //   println(frameCount / 60);
  // }
}
