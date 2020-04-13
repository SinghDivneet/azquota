#! /bin/bash

SP_USERNAME=$1
SP_PASSWORD=$2
SP_TENANT=$3
SubscriptionId=$4
#Desired Azure Regions
declare -a regions=( "$@" )

#Not happy with the below 4 lines of logic ... badly need some caffeine
unset 'regions[0]'
unset 'regions[1]'
unset 'regions[2]'
unset 'regions[3]'

echo "Retrieving data for regions: ${regions[@]}"

#Login using Service Principal
spdata=$(az login --service-principal --username $SP_USERNAME --password $SP_PASSWORD --tenant $SP_TENANT)

az account set -s $SubscriptionId


for region in ${regions[@]}; do

   az account show -o table > $SubscriptionId"_"$region.csv

   echo "===========================" >> $SubscriptionId"_"$region.csv 
   echo " " >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv

#Compute quotas
   echo "Fetching Compute Quota for region -- $region for subscription id: $SubscriptionId started"
   echo "Compute Quota for region -- $region" >> $SubscriptionId"_"$region.csv
   echo "===========================" >> $SubscriptionId"_"$region.csv
   az vm list-usage -l $region -o table >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv
   echo "Fetching Compute Quota for region -- $region for subscription id: $SubscriptionId completed"
   echo " "

#Network quotas
   echo "Fetching Network Quota for region -- $region for subscription id: $SubscriptionId started"
   echo "Network Quota for region -- $region" >> $SubscriptionId"_"$region.csv
   echo "===========================" >> $SubscriptionId"_"$region.csv
   az network list-usages -l $region -o table >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv
   echo "Fetching Network Quota for region -- $region for subscription id: $SubscriptionId completed"
   echo " "

#Storage quotas   
   echo "Fetching Storage Quota for region -- $region for subscription id: $SubscriptionId started"
   echo "Storage Quota for region -- $region" >> $SubscriptionId"_"$region.csv
   echo "===========================" >> $SubscriptionId"_"$region.csv
   az storage account show-usage -l $region -o table >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv
   echo "Fetching Storage Quota for region -- $region for subscription id: $SubscriptionId completed"
   echo " "

#HDInsight quotas
   echo "Fetching HDInsight Quota for region -- $region for subscription id: $SubscriptionId started"
   echo "HDInsight Quota for region -- $region" >> $SubscriptionId"_"$region.csv
   echo "===========================" >> $SubscriptionId"_"$region.csv
   az hdinsight list-usage -l $region | egrep -w 'currentValue|limit' | sed 's/,//' >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv
   echo "Fetching HDInsight Quota for region -- $region for subscription id: $SubscriptionId completed"
   echo " "

#SQL quotas
   echo "Fetching SQL Quota for region -- $region for subscription id: $SubscriptionId started"
   echo "SQL Quota for region -- $region" >> $SubscriptionId"_"$region.csv
   echo "===========================" >> $SubscriptionId"_"$region.csv
   az sql list-usages -l $region -o table >> $SubscriptionId"_"$region.csv
   echo " " >> $SubscriptionId"_"$region.csv
   echo "Fetching SQL Quota for region -- $region for subscription id: $SubscriptionId completed"
   echo " "

done


