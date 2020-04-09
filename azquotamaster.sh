#! /bin/bash

#Step1
#Enter the regions for which the quota information is to be fetched. Example as below
#regionarr=('southeastasia' 'eastus')

#Step2
#Create an AAD service principal and enter the relevant details.
#More information on creation of AAD service principal here - https://docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac
#Example as below
#./azquotaworker.sh "http://myspname" "my_sp_password" "tenant_id" "subscription_id" "${regionarr[@]}"

regionarr=('<region1>' '<region2>')
./azquotaworker.sh "<sp_name>" "<sp_password>" "<tenant_id>" "<subscription_id>" "${regionarr[@]}"

#Repeat the above two lines with relevant details for fetching the quota information for different subscription ids
