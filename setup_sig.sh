region=signal
sigtype=eta
debug="0" # -1 = very quiet, 0 = quiet, 1 = verbose, 2+ = debug
extra_points=0 # 0 = none, 1 = ...
toys=15000

input="./input"
#signal="signal_10percent_eta"
#signal="signal_10percent_etaprime"
signal="signal_10percent_lowerphimass_eta"
#signal="signal_10percent_lowerphimass_etaprime"

# first last npoints
wmasspoints=(0.5 4 11)
pmasspoints=(550 2925 20)
#wmasspoints=(2.0 3.0 5)
#pmasspoints=(1000 1500 6)
#wmasspoints=(2.0 3.0 9)
#pmasspoints=(1000 1500 11)

masses=(55)
#masses=($(seq 0 $(( ${wmasspoints[2]} * ${pmasspoints[2]} - 1 ))))
#masses=($(seq 0 285))

sed -i "s|^extra_points = .*|extra_points = $extra_points|" files.py
sed -i "s|input_top_level = '.*'|input_top_level = '$input'|" files.py
sed -i "s|signal_input = '.*'|signal_input = '$signal'|" files.py
sed -i "s/^wmasspoints = numpy\.linspace(.*)$/wmasspoints = numpy.linspace(${wmasspoints[0]}, ${wmasspoints[1]}, ${wmasspoints[2]})/" files.py
sed -i "s/^pmasspoints = numpy\.linspace(.*)$/pmasspoints = numpy.linspace(${pmasspoints[0]}, ${pmasspoints[1]}, ${pmasspoints[2]})/" files.py
