SRCS = $(wildcard *.py)
OBJS = $(patsubst %.py,%.tex,$(SRCS))

%.tex: %.py
	pygmentize -f latex -O full $< | perl -p0777i -e 's/.*(\\begin{Verbatim}.*\\end{Verbatim}\n).*/\1/ms' > $@

all: $(OBJS)
