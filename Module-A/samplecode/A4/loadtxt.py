from pylab import *

Fx, Fy = loadtxt("data.txt", comments="#",
                 usecols=(0,1), unpack=True)

plot(Fx, Fy, marker='+', linestyle='-', linewidth=1.0)

xlabel('x')
ylabel('x^2')
grid(True)
show()

