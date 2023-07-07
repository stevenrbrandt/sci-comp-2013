#!/usr/bin/python

# Plot evolution of central density
from plot_defaults import *

# load data
Fx, Fy = numpy.loadtxt("hydrobase::rho.maximum.asc.bz2",
                       comments="#", usecols=(1,2), unpack=True)

# plot basics
fig = plt.figure(figsize=(6, 3))
fig.subplots_adjust(top=0.85, bottom=0.16, left=0.11,right=0.97)
ax = fig.add_subplot(1,1,1)

# plot
ax.plot(Fx, Fy/Fy[0], linestyle='-', color='black')

ax.set_xlabel(r't [M]')
ax.xaxis.set_minor_locator(mticker.AutoMinorLocator())
ax.xaxis.grid(False)
ax2 = ax.twiny()
ax2.set_xlabel(r't [ms]')
ax2.set_xlim((ax.get_xlim()[0]/M_to_ms, ax.get_xlim()[1]/M_to_ms))
ax2.xaxis.set_minor_locator(mticker.AutoMinorLocator())
ax.set_ylabel(r'$\varrho_c/\varrho_c(0)$')
ax.yaxis.set_major_locator(mticker.MaxNLocator(4))
ax.yaxis.set_minor_locator(mticker.AutoMinorLocator())
ax.yaxis.grid(False)
set_tick_sizes(ax, 8, 4)

#plt.show()
plt.savefig('rho_max.pdf')

