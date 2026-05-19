vcftools --vcf 50.vcf --max-missing 0.90 --recode --recode-INFO-all --out filtered1

#kept 15606 sites from 5725 loci

#vcftools --vcf ../90_filtering/filtered1.recode.vcf --keep ../west.txt --recode --recode-INFO-all --out west
#vcftools --vcf ../90_filtering/filtered1.recode.vcf --keep ../west1.txt --recode --recode-INFO-all --out west1
#vcftools --vcf ../90_filtering/filtered1.recode.vcf --keep ../west_total.txt --recode --recode-INFO-all --out west_total
#vcftools --vcf ../90_filtering/filtered1.recode.vcf --keep ../CoastSouth.txt --recode --recode-INFO-all --out CoastSouth
#vcftools --vcf ../90_filtering/filtered1.recode.vcf --keep ../CoastNorth.txt --recode --recode-INFO-all --out CoastNorth