for i in {1..15}; do
  mkdir run$i
  cd run$i
  cp ../CoastNorth.tpl ../CoastNorth.est ../CoastNorth*.obs .
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  ../../../../../../fsc28 -t CoastNorth.tpl -n 100000 -m -e CoastNorth.est -M -L 40 -q --foldedSFS -c 8
  cd ..
done

grep -H "" run*/CoastNorth/CoastNorth.bestlhoods | cut -f1,2,3,4,5,6
