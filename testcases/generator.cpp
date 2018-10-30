#include <bits/stdc++.h>
#include <random>
#include "testlib.h"
using namespace std;

const int CASE = 20;
const int MIN_V = 1;
const int MAX_V = 1000;

int main(int argc, char* argv[]){
  random_device rng;
  unsigned int seed = rng();
  rnd.setSeed(seed);
  registerGen(argc, argv, 1);

  for(int tid = 0; tid < CASE; tid++){
    ofstream fnode(format("02_random_node_%02d.in", tid).c_str());
    ofstream fedge(format("02_random_edge_%02d.in", tid).c_str());

    int V = rnd.next(MIN_V, MAX_V);
    fnode << V << endl;

    double edge_prob = rnd.next();
    for(int i = 0; i < V; i++){
      for(int j = i + 1; j < V; j++){
        double prob = rnd.next();
        if(edge_prob > prob) {
          fedge << i+1 << " " << j+1 << endl;
        }
      }
    }
  }

}
