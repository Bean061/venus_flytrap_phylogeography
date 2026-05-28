for i in {1..15}; do
  mkdir run$i
  cd run$i
  cp ../West.tpl ../West.est ../West*.obs .
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  ../../../../../../fsc28 -t West.tpl -n 100000 -m -e West.est -M -L 40 -q --foldedSFS -c 20
  cd ..
done
