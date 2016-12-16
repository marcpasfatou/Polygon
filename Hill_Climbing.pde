

class Polygon {
  private int r,g,b;
  private float x1, y1, x2, y2, x3, y3, x4, y4;
  private float alpha;
  
  public Polygon (){
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
  
  public void draw(){
    stroke(this.r,this.g,this.b, this.alpha);
    fill(this.r,this.g,this.b,this.alpha);
    quad(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3, this.x4, this.y4);
    
    
  }
  
  public void set(float[] properties ){
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
  
  public float[] get(){
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
}