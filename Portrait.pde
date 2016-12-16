import gab.opencv.*;



PImage img;
Vector polygons = new Vector(50);
Polygon[] parent = new Polygon[50];
void setup(){
 size(800,600);
  background(0);
  img = loadImage("Sunflower.jpg"); 
for (int i = 0; i < 50; i++){
  parent[i] = new Polygon();
}

}

void draw(){
  //image(img,0,0);

  
for (int i = 0; i < 50; i++){
  parent[i].draw();
}
}