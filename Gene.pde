import java.util.*;



class Polygon {
  private int r, g, b;
  private float x1, y1, x2, y2, x3, y3, x4, y4;
  private float alpha;

  public Polygon () {
    this.r = int(random(256));
    this.g = int(random(256));
    this.b = int(random(256));

    this.x1 = random(width);
    this.x2 = random(width);
    this.x3 = random(width);
    this.x4 = random(width);
    this.y1 = random(height);
    this.y2 = random(height);
    this.y3 = random(height);
    this.y4 = random(height);

    this.alpha = random(255);
  }

  public Polygon (Polygon other) {
    this.r = other.r;
    this.g = other.g;
    this.b = other.b;

    this.x1 = other.x1;
    this.x2 = other.x2;
    this.x3 = other.x3;
    this.x4 = other.x4;
    this.y1 = other.y1;
    this.y2 = other.y2;
    this.y3 = other.y3;
    this.y4 = other.y4;

    this.alpha = other.alpha;
  }

  public void draw() {
    stroke(this.r, this.g, this.b, this.alpha);
    fill(this.r, this.g, this.b, this.alpha);
    quad(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3, this.x4, this.y4);
  }

  public void set(float[] properties ) {
    this.r = (int)properties[0];
    this.g = (int)properties[1];
    this.b = (int)properties[2];

    this.x1 = properties[3];
    this.x2 = properties[4];
    this.x3 = properties[5];
    this.x4 = properties[6];
    this.y1 = properties[7];
    this.y2 = properties[8];
    this.y3 = properties[9];
    this.y4 = properties[10];

    this.alpha = properties[11];
  }

  public float[] get() {
    float[] properties = new float[12];

    properties[0] = this.r;
    properties[1] = this.g;
    properties[2] = this.b;

    properties[3] = this.x1;
    properties[4] = this.x2;
    properties[5] = this.x3;
    properties[6] = this.x4;
    properties[7] = this.y1;
    properties[8] = this.y2;
    properties[9] = this.y3;
    properties[10] = this.y4;

    properties[11] = this.alpha;

    return properties;
  } 

  public void mutate(){
    this.r = int(random(256));
    this.g = int(random(256));
    this.b = int(random(256));
    //while(abs(this.x1 - this.x3)> 40  || abs(this.x2 - this.x4)> 40 || abs(this.y1 - this.y3)> 40  || abs(this.y2 - this.y4)> 40 ){
    this.x1 = random(width);
    this.x2 = random(width);
    this.x3 = random(width);
    this.x4 = random(width);
    this.y1 = random(height);
    this.y2 = random(height);
    this.y3 = random(height);
    this.y4 = random(height);
  //}
    
    this.alpha = random(255);
  
  }
}


class Drawing implements Comparable<Drawing>{
  Polygon[] shapes;
  double fitness;
  int size;
  public Drawing(int nshapes) {
    this.shapes = new Polygon[nshapes];
    this.size = nshapes;
    for (int i = 0; i < nshapes; i++) {
      this.shapes[i] = new Polygon();
      this.fitness = -1;    
    }
  }
  
   public Drawing(Drawing other) {
    this.shapes = other.shapes;
    this.size = other.size;    
    }
  
  
  public void draw(){
   for (int i = 0; i < this.size; i++) {
     this.shapes[i].draw();
   }
  }
  
  public double fitness(PImage img){
  float fitness = 0;
  
  img.loadPixels();
  loadPixels();
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float deltaRed = red(img.pixels[loc]) - red(pixels[loc]);
      float deltaGreen = green(img.pixels[loc]) - green(pixels[loc]);
      float deltaBlue = blue(img.pixels[loc]) - blue(pixels[loc]);
      
      float pixelFitness = deltaRed * deltaRed +
                                deltaGreen * deltaGreen +
                                deltaBlue * deltaBlue;      
                                
      fitness += pixelFitness;
    }
  }
  this.fitness = fitness;
  return fitness;  
}
  
  public void copy(Drawing other){
    
    for (int i = 0; i < this.size; i++) {
      this.shapes[i] = new Polygon(other.shapes[i]);
      this.fitness = -1;
    }
  }
  
  @Override
  public int compareTo(Drawing o){
    return new Double(this.fitness).compareTo(new Double(o.fitness));
  } 
}


class GenAlg {
  Drawing[] Pop; //number of images
  int popSize;
  int ChrLen;
  float mutRate;
  float crossRate;
  int numGen;
  float perturbation;
  int numCopies = 3;
  int numBest = 4;
  public GenAlg(int popSize, int ChrLen, float mutRate, float crossRate) {
    this.Pop = new Drawing[popSize];
    for(int n = 0; n < popSize; n++){
      this.Pop[n] = new Drawing(ChrLen);
    }
    this.popSize = popSize;
    this.ChrLen = ChrLen;
    this.mutRate =mutRate;
    this.crossRate = crossRate;
    
  }
  
  public void setShapes(Drawing[] otherPop){
    for(int n = 0; n < this.popSize; n++){
      this.Pop[n] = new Drawing(otherPop[n]);
    }
  }
  private void crossover(Drawing mum, Drawing dad, Drawing baby1, Drawing baby2) {
    if (random(100) > this.crossRate || Arrays.deepEquals(mum.shapes, dad.shapes)) {
        baby1.copy(mum);
        baby2.copy(dad);
    }
    
    int chiasma = int(random(ChrLen));
    
    for(int i = 0; i < chiasma; i ++){
      baby1.shapes[i] = new Polygon(mum.shapes[i]);
      baby2.shapes[i] = new Polygon(dad.shapes[i]);
    }
    
    for(int i = chiasma; i < this.ChrLen; i ++){
      baby1.shapes[i] = new Polygon(dad.shapes[i]);
      baby2.shapes[i] = new Polygon(mum.shapes[i]);
    }
  }

  public GenAlg update() {
    this.draw();
    Arrays.sort(Pop);
    GenAlg newGen = new GenAlg(this.popSize, this.ChrLen, this.mutRate, this.crossRate);
    //debug
      //for(int i = 0; i < popSize; i++){    
      println(Pop[0].fitness);
      //crossover(this.Pop[int(random(7))], this.Pop[int(random(7))], newGen.Pop[1],newGen.Pop[2]);
    for(int i = 0; i < this.popSize; i+=2){
      //println(i);
    crossover(this.Pop[int(random(this.popSize/2))], this.Pop[int(random(this.popSize/2))], newGen.Pop[i],newGen.Pop[i+1]);
    }
    
    for(int i = 0; i < popSize; i++){
      for(int j = 0; j < ChrLen; j++){
        if(random(100)>this.mutRate){
        newGen.Pop[i].shapes[j].mutate();
        }
      }
    }
    return newGen;
    }
//  }
  
  public void draw(){
    for(int i = 0; i < popSize; i++){
      background(0);
      Pop[i].draw();
      Pop[i].fitness(img);
      //println(Pop[i].fitness);
    }
  }
}