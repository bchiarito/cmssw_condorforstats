region=signal
sigtype=eta
debug="0" # -1 = very quiet, 0 = quiet, 1 = verbose, 2+ = debug
extra_points=0 # 0 = none, 1 = ...
toys=1000

input="./input"
#signal="signal_10percent_eta"
#signal="signal_10percent_etaprime"
signal="signal_10percent_lowerphimass_eta"
#signal="signal_10percent_lowerphimass_etaprime"

# first last npoints
#wmasspoints=(0.5 4 11)
#pmasspoints=(550 2925 20)
#wmasspoints=(2.0 3.0 5)
#pmasspoints=(1000 1500 6)
#wmasspoints=(2.0 3.0 9)
#pmasspoints=(1000 1500 11)

# widths 0.35, 125
#wmasspoints=(0.5 4 11)
#pmasspoints=(550 2925 20)

# widths 0.15, 30
wmasspoints=(0.5 3.95 24)
pmasspoints=(550 2920 80)

# widths 0.15, 30 | high sig region
#wmasspoints=(1.1 3.5 17)
#pmasspoints=(1000 1510 18)

#masses=(559 561 563)
#masses=(634)
masses=($(seq 0 $(( ${wmasspoints[2]} * ${pmasspoints[2]} - 1 ))))
#masses=(140 512 513 535 536 539 560 562 563 564 586 587 588 589 601 611 612 614 632 634 635 636 637 73 87 89)
#masses=(139 165 167 291 433 435 457 481 486 517 528 535 558 559 560 561 562 563 564 583 584 586 587 588 609 611 612 63 632 633 634 636 637 64 65 655 956)
#masses=(517 139 655 533 534 661 539 541 164 683 559 560 561 562 563 564 67 583 584 586 587 608 609 611 612 613 486 633 634 636 637)
#masses=($(seq 0 285))

sed -i "s|^extra_points = .*|extra_points = $extra_points|" files.py
sed -i "s|input_top_level = '.*'|input_top_level = '$input'|" files.py
sed -i "s|signal_input = '.*'|signal_input = '$signal'|" files.py
sed -i "s/^wmasspoints = numpy\.linspace(.*)$/wmasspoints = numpy.linspace(${wmasspoints[0]}, ${wmasspoints[1]}, ${wmasspoints[2]})/" files.py
sed -i "s/^pmasspoints = numpy\.linspace(.*)$/pmasspoints = numpy.linspace(${pmasspoints[0]}, ${pmasspoints[1]}, ${pmasspoints[2]})/" files.py
