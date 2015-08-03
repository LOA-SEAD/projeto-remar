png=".png"

cd $1
cd assets

file=`find . -type f -name $2$png`

if [[ -n "$file" ]]; then
	cp $file ../../../../images/
	echo "1"
else
	echo "0" 
fi
