import java.util.*;

public class Gene {
int r,g,b = 0;
float x1, x2, x3, y1,y2,y3 = 0;
}

class Chromosome{
  int Fitness;
  Vector genes = new Vector(150); //number of triangles in one image
}

class GenAlg{
  Vector pop = new Vector(12); //number of images
  int popSize;
  int ChrLen;
  float mutRate;
  float crossRate;
  int numGen;
  float perturbation;
  int numCopies = 5;
  int numBest = 4;
  public GenAlg(){
    
  }
}