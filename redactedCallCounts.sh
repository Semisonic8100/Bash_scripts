#!/bin/sh
while [ 1 ]
do
reportTime=`date`

vg161ORL=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg162ORL=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg163ORL=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg164ORL=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg165ORL=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )

vg161LAS=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg162LAS=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg163LAS=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg164LAS=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )
vg165LAS=$( snmpget -c mayant.aye -v 1 -Oqv [redacted] )

(( orlandoTotal = vg161ORL + vg162ORL + vg163ORL + vg164ORL + vg165ORL ))
(( vegasTotal = vg161LAS + vg162LAS + vg163LAS + vg164LAS + vg165LAS ))
(( totalcalls = orlandoTotal + vegasTotal ))
cat << EOF
vg161.orl = $vg161ORL
vg162.orl = $vg162ORL
vg163.orl = $vg163ORL
vg164.orl = $vg164ORL
vg165.orl = $vg165ORL

vg161.las = $vg161LAS
vg162.las = $vg162LAS
vg163.las = $vg163LAS
vg164.las = $vg164LAS
vg165.las = $vg165LAS

Orlando total = $orlandoTotal
Las total = $vegasTotal
Total Calls = $totalcalls
$reportTime
EOF

done
