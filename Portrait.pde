import gab.opencv.*;



PImage img;
//Vector polygons = new Vector(1000);
//Polygon[] parent = new Polygon[1000];
Polygon testpoly = new Polygon();
//Drawing[] testdrawing = new Drawing[10];
GenAlg test = new GenAlg(36,50,70,90);
float[] fitness = new float[12];
Drawing testdrawing = new Drawing(50);
int generation = 0;
int step = 0;

void setup(){
  background(0);
  img = loadImage("Sunflower.jpg"); 
  size(200,200);


}

void draw(){
//test.draw();
test.setShapes(test.update().Pop);
//testdrawing.draw();
//testpoly.draw();
generation ++;
}