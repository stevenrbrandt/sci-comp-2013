#!/usr/bin/python
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import numpy
from matplotlib import rc
fontsize  = 10
linewidth = 2
rc('text', usetex=True)
rc('font', family='serif'); rc('font', serif='palatino');
rc('font', weight='bolder'); rc('mathtext', default='sf')
rc("lines", markeredgewidth=1)
rc("lines", linewidth=linewidth)
rc('axes', labelsize=fontsize); rc("axes", linewidth=(linewidth+1)//2)
rc('xtick', labelsize=fontsize); rc('ytick', labelsize=fontsize)
rc('legend', fontsize=fontsize)
rc('xtick.major', pad=8); rc('ytick.major', pad=8)

def set_tick_sizes(ax, major, minor):
    for l in ax.get_xticklines() + ax.get_yticklines():
        l.set_markersize(major)
    for tick in ax.xaxis.get_minor_ticks() + ax.yaxis.get_minor_ticks():
        tick.tick1line.set_markersize(minor); tick.tick2line.set_markersize(minor)
    ax.xaxis.LABELPAD      = 10.
    ax.xaxis.OFFSETTEXTPAD = 10.

# constants, in SI
G = 6.673e-11       # m^3/(kg s^2)
c = 299792458       # m/s
M_sol = 1.98892e30  # kg
# convertion factors
M_to_ms = 1./(1000*M_sol*G/(c*c*c))
M_to_density = c*c*c*c*c*c / (G*G*G * M_sol*M_sol) # kg/m^3
