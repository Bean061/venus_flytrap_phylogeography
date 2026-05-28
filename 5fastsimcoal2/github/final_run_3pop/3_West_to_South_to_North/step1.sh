for i in {1..15}; do
  mkdir run$i
  cd run$i
  cp ../total.tpl ../total.est ../total*.obs .
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  ../../../../../fsc28 -t total.tpl -n 100000 -m -e total.est -M -L 40 -q --foldedSFS --multiSFS -c 40
  cd ..
done
