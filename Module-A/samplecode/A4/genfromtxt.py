from pylab import *

Fx, Fy = genfromtxt("data2.txt", comments="#",
                    usecols=(0,1), unpack=True,
                    invalid_raise=False)

plot(Fx, Fy, marker='+', linestyle='-', linewidth=1.0)

xlabel('x')
ylabel('x^2')
grid(True)
show()

