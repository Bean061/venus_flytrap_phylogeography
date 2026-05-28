for i in {1..15}; do
  mkdir run$i
  cd run$i
  cp ../CoastSouth.tpl ../CoastSouth.est ../CoastSouth*.obs .
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  ../../../../../../fsc28 -t CoastSouth.tpl -n 100000 -m -e CoastSouth.est -M -L 40 -q --foldedSFS -c 20
  cd ..
done

grep -H "" run*/CoastSouth/CoastSouth.bestlhoods | cut -f1,2,3,4,5,6
