#include <iostream>
#include <cmath>

main(){
  double r0=5;
  double step=1;
  double len=1;

  double k = 1200.0 / 1.05 / 2.54;

  std::cout << "#FIG 3.2\nLandscape\nCenter\nMetric\nA4\n100.00\nSingle\n"
            << "-2\n1200 2\n";

  std::cout << "1 3 0 1 0 7 50 -1 -1 0.000 1 0.0000 0 0 2250 2250 0 0 2250 0\n";

  for (double x=-r0; x<=r0; x+=step){
    for (double y=-r0; y<=r0; y+=step){
      double r=sqrt(x*x+y*y)/r0;
      if (r>1) continue;

      double rx=sqrt(3.0/5.0*r);
      double ry=sqrt(1.0/5.0*r);
      double rz=sqrt(1.0/5.0*r + (1-r));

      double a=atan2(y,x) + atan2(rx,ry);

      int x1 = int(x*k);
      int x2 = int(x*k-len*(rx*rx+ry*ry)*cos(a)*k);
      int y1 = int(y*k);
      int y2 = int(y*k-len*(rx*rx+ry*ry)*sin(a)*k);

      std::cout << "2 1 0 1 0 7 50 -1 -1 0.000 0 0 -1 1 0 2\n"
                << "		1 1 1.00 30.00 45.00\n"
		<< "		" << x1 << " " << y1 << " "
                 << x2 << " " << y2 << "\n";

    }
  }

  for (double x=-r0; x<=r0; x+=step){
    for (double z=-r0; z<=r0; z+=step){

      double r=fabs(x/r0);
      double s=x<0?-1:1;

      double rx=sqrt(3.0/5.0*r)*s;
      double ry=sqrt(1.0/5.0*r);
      double rz=sqrt(1.0/5.0*r + (1-r));

      int x1 = int(2.4*r0*k + x*k);
      int x2 = int(2.4*r0*k + x*k - len*rx*k);
      int y1 = int(z*k);
      int y2 = int(z*k - len*rz*k);

      std::cout << "2 1 0 1 0 7 50 -1 -1 0.000 0 0 -1 1 0 2\n"
                << "		1 1 1.00 30.00 45.00\n"
		<< "		" << x1 << " " << y1 << " "
                 << x2 << " " << y2 << "\n";

    }
  }
}
