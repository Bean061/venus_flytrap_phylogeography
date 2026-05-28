for i in {1..15}; do
  mkdir output_run$i
  cd output_run$i
  cp ../run$i/total/total.bestlhoods ./
  cp ../run$i/total.est ./
  cp ../AIC.R ./
  Rscript AIC.R total
  #../../fsc28 -t <template>.tpl -n 100000 -e <estimation>.est -M -L 40 -q --foldedSFS > log.txt
  #../../../../../../fsc28 -t West.tpl -n 100000 -m -e West.est -M -L 40 -q --foldedSFS -c 20
  cd ..
done

#find . -path "./*/total.AIC" -exec awk '{print FILENAME "\t" $0}' {} +
