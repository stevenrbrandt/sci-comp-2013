#!/usr/bin/python

# Plot evolution of central density
from plot_defaults import *

# load data
F8x, F8y = numpy.loadtxt("dx8.asc.bz2",
                         comments="#", usecols=(1,2), unpack=True)
F4x, F4y = numpy.loadtxt("dx4.asc.bz2",
                         comments="#", usecols=(1,2), unpack=True)

# plot basics
fig = plt.figure(figsize=(6, 3))
fig.subplots_adjust(top=0.85, bottom=0.16, left=0.11,right=0.97)
ax = fig.add_subplot(1,1,1)

# plot
ax.plot(F4x/M_to_ms, F4y/F4y[0]*100, linestyle='--', color='blue' , label='dx = 4')
ax.plot(F8x/M_to_ms, F8y/F8y[0]*100, linestyle='-',  color='black', label='dx = 8')

ax.set_xlim(0, 1300/M_to_ms)
ax.set_ylim(99, 100.5)
ax.set_xlabel(r't [ms]')
ax.xaxis.set_minor_locator(mticker.AutoMinorLocator())
ax2 = ax.twiny()
ax2.set_xlabel(r't [M]')
ax2.xaxis.set_minor_locator(mticker.AutoMinorLocator())
ax2.set_xlim((ax.get_xlim()[0]*M_to_ms, ax.get_xlim()[1]*M_to_ms))
ax2.xaxis.grid(False)
ax.set_ylabel(r'$\varrho_c/\varrho_c(0)$ [\%]')
ax.yaxis.set_major_locator(mticker.MaxNLocator(4))
ax.yaxis.set_minor_locator(mticker.AutoMinorLocator())
ax.yaxis.grid(False)
set_tick_sizes(ax, 8, 4)

handles, labels = ax.get_legend_handles_labels()
leg = ax.legend(handles, labels, loc='best', handlelength=4)

#plt.show()
plt.savefig('rho_max_coursework.pdf')

