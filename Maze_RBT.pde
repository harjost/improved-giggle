
/* 
Code written and developed by Harjot Singh Tathgur
11/22/2020
*/


// Global Declarations before Maze is made
int WIDTH = 1400;
int HEIGHT = 900;
// Change block length to change how large the maze is
int blockLength = 100;
Point[][] mazePoints = createMazeArr(WIDTH/blockLength, HEIGHT/blockLength);
Boolean[][] horizontals = createHorizontalOrVerticalArr(WIDTH/blockLength, HEIGHT/blockLength-1);
Boolean[][] verticals = createHorizontalOrVerticalArr(WIDTH/blockLength-1, HEIGHT/blockLength);
int randomX = floor(random(WIDTH/blockLength));
int randomY = floor(random(HEIGHT/blockLength));


// Global Declarations after Maze is made
HorAndVertLines horAndVert = createMaze(randomX, randomY, 0);

// Point Class
class Point {
  int x;
  int y;
  boolean visited;
  
  Point(int x, int y, boolean visited) {
    this.x = x;
    this.y = y;
    this.visited = visited;
  }
  
  void setVisited(boolean status) {
    this.visited = status;
  }
  
  int getX() {
    return this.x; 
  }
  
  int getY() {
    return this.y; 
  }
  
  boolean getVisited() {
    return this.visited; 
  }
}

class HorAndVertLines {
  
  Boolean[][] hor;
  Boolean[][] vert;
  
  HorAndVertLines(Boolean[][] hor, Boolean[][] vert) {
    this.hor = hor;
    this.vert = vert;
  }
  
  Boolean[][] getHor() {
    return this.hor; 
  }
  
  Boolean[][] getVert() {
    return this.vert; 
  }
}

// Create Maze Array
Point[][] createMazeArr(int x, int y) {
  Point[][] mazePoints = new Point[x][y];
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      mazePoints[i][j] = new Point(i,j,false);
    }
  } 
  return mazePoints;
}

// Create Horizontal and Vertical Arrays
Boolean[][] createHorizontalOrVerticalArr(int x, int y) {
  Boolean[][] horizontalOrVertical = new Boolean[x][y];
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      horizontalOrVertical[i][j] = true;
    }
  }
  
  return horizontalOrVertical;
}

HorAndVertLines createMaze(int currX, int currY, int visited) { 
  // Return lines
  if (visited == (WIDTH/blockLength)*(HEIGHT/blockLength)) {
    return new HorAndVertLines(horizontals, verticals);
  }
  
  // Increment Visited Counter and Update Maze Points Visited Attribute
  mazePoints[currX][currY].setVisited(true);
  visited++;
  
  ArrayList<Integer> directionsVisited = new ArrayList<Integer>();
  
  // Possible directions:
  // 0-top : 1-right : 2-down : 3-left  
  for (int i = 0; i < 4; i++) {
    
    int direction = floor(random(4));
    
    if (directionsVisited.contains(direction)) {
      i--;
      continue;
    }
    
    directionsVisited.add(direction);
    
    if (direction == 0) {
      if (currY == 0 || mazePoints[currX][currY-1].getVisited() == true) {
        continue;
      } else {
        horizontals[currX][currY-1] = false;
        createMaze(currX, currY-1, visited);
      }
    } else if (direction == 1) {
      if (currX == WIDTH/blockLength-1 || mazePoints[currX+1][currY].getVisited() == true) {
        continue;
      } else {
        verticals[currX][currY] = false;
        createMaze(currX+1, currY, visited);
      }
    } else if (direction == 2) {
      if (currY == HEIGHT/blockLength-1 || mazePoints[currX][currY+1].getVisited() == true) {
        continue;
      } else {
        horizontals[currX][currY] = false;
        createMaze(currX, currY+1, visited);
      }
    } else {
      if (currX == 0 || mazePoints[currX-1][currY].getVisited() == true) {
        continue;
      } else {
        verticals[currX-1][currY] = false;
        createMaze(currX-1, currY, visited);
      }
    }
  }
  
  return new HorAndVertLines(horizontals, verticals);
}

void setup() {
  size(1400, 900);
  stroke(255);
  strokeWeight(5);
}

void draw() { 
  background(0);
  
  line(0,0,WIDTH,0);
  line(0,0,0,HEIGHT);
  line(0,HEIGHT,WIDTH,HEIGHT);
  line(WIDTH,0,WIDTH,HEIGHT);
  
  for (int i = 0; i < WIDTH/blockLength; i++) {
    for (int j = 0; j < HEIGHT/blockLength-1; j++) {
      if (horAndVert.hor[i][j] == true) {
        line(i*blockLength,blockLength*(j+1),(i+1)*blockLength,blockLength*(j+1));
      }
    }
  }
  
  for (int i = 0; i < WIDTH/blockLength-1; i++) {
    for (int j = 0; j < HEIGHT/blockLength; j++) {
      if (horAndVert.vert[i][j] == true) {
        line((i+1)*blockLength,blockLength*j,(i+1)*blockLength,blockLength*(j+1));
      }
    }
  }
}
