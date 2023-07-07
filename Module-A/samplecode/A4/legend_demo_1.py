#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

a = np.arange(0,3,.02)
b = np.arange(0,3,.02)
c = np.exp(a)
d = c[::-1]

ax = plt.subplot(111)
plt.plot(a,c,'k--',a,d,'k:',a,c+d,'k')
plt.legend(('Model length', 'Data length',
            'Total message length'),
           'upper center', shadow=True,
            fancybox=True)
plt.ylim([-1,20])
plt.grid(False)
plt.xlabel('Model complexity --->')
plt.ylabel('Message length --->')
plt.title('Minimum Message Length')

plt.setp(plt.gca(), 'yticklabels', [])
plt.setp(plt.gca(), 'xticklabels', [])

