# set some legend properties.  All the code below is optional.
# The defaults are usually sensible but if you need more control,
# this shows you how
leg = plt.gca().get_legend()
ltext  = leg.get_texts()  # all the text.Text instance
llines = leg.get_lines()  # all the lines.Line2D instance
frame  = leg.get_frame()  # the surrounding patch.Rectangle inst.

# see text.Text, lines.Line2D, and patches.Rectangle for more
# info on the settable properties of lines, text, and rectangles
frame.set_facecolor('0.80')       # set the frame face color
plt.setp(ltext, fontsize='small') # the legend text fontsize
plt.setp(llines, linewidth=1.5)   # the legend linewidth
#leg.draw_frame(False)            # don't draw the legend frame
plt.show()

