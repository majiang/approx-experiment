dub --vquiet --build=release -- -s 2 -m 8 -q 1024
dub --vquiet --build=release -- -s 2 -m 12 -q 1024
dub --vquiet --build=release -- -s 2 -m 16 -q 1024
dub --vquiet --build=release -- -s 4 -m 8 -q 1024
dub --vquiet --build=release -- -s 4 -m 12 -q 1024
dub --vquiet --build=release -- -s 4 -m 16 -q 1024
dub --vquiet --build=release -- -s 8 -m 8 -q 1024
dub --vquiet --build=release -- -s 8 -m 12 -q 1024
dub --vquiet --build=release -- -s 8 -m 16 -q 1024
dub --vquiet --build=release -- -s 16 -m 8 -q 1024
dub --vquiet --build=release -- -s 16 -m 12 -q 1024
dub --vquiet --build=release -- -s 16 -m 16 -q 1024
r --vanilla --slave < draw-graph.r
