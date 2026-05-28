for i in {3..15}; do
  mkdir run$i
  cd run$i
  cp ../total.tpl ../total.est ../total*.obs .
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  ../../../../../../fsc28 -t total.tpl -n 100000 -m -e total.est -M -L 40 -q --foldedSFS --multiSFS -c 40
  cd ..
done

#0 West1
#1 West
#2 South
#3 North
