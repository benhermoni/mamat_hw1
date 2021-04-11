#!/bin/bash
wget https://www.premierleague.com/players
while read -r line
do for word in $(echo $line | tr "=\"" " ")
do if [[ $word == *"/players/"*"/"*"/overview"* ]]
then if ! [[ "${word}" =~ [^a-zA-z0-9/-] ]]
then echo $word >> urls.txt
fi
fi
done
done < players
(( counter=0 ))
while read -r line
do
((counter=${counter}+1))
done < urls.txt
sed -i 's/\/players/https:\/\/www\.premierleague\.com\/players/' urls.txt
while read -r line
do wget $line
amount=$(sed 's/Midfielder/Midfielder\n/g' overview | grep -c 'Midfielder')
rm overview
echo $amount; echo $line
final=$line", Midfielder, "$amount
if [[ $amount != 0 ]]
then echo $final >> results.csv.txt
fi
done < urls.txt