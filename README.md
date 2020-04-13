# azquota
Shell scripts to fetch the quota information for the Compute, Network and Storage resources for the desired subscriptions in Microsoft Azure.  

Backdrop:
=========
The quota information is all about how much resources are allocated for a subscription and how much of those resources are being actually used. This helps one to plan their deployments.<br/>

There are in all 2 shell scripts which help to fetch the quota information as follows: <br />
<b>azquotaworker.sh:</b> This is the script which does the actual work of fetching the quota information for a subscription.
<b>azquotamaster.sh:</b> This is the script which feeds the parameters to the azquotaworker.sh and then executes it.

Only the azquotamaster.sh is to be modified with the relevant details. <br/> 
azquotaworker.sh just does the work of fetching the data.<br/>
Both the shell scripts are to be copied to the same directory and are to be made executable. The quota information is generated as a .csv per subscription per region. The csv file naming will be of the format <Subscription_id>_<region>.csv  


Prerequisites:
==============
az-cli is needed for the scripts to work -- https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest


Usage:
======

Step a:
To use azquotamaster.sh, an Azure Active Directory service principal is to be created -- https://docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac . <br/>
The default command for the same is: <br/>
az ad sp create-for-rbac -n "<sp_name>"

The above command gives the below output: <br/>
{
  "appId": "<your app id>",
  "displayName": "<sp_name>",
  "name": "http://<sp_name>",
  "password": "<sp_password>",
  "tenant": "<tenant_id>"
}

Step b:
Copy azquotamaster.sh and azquotaworker.sh in the same directory. Now based on the output received above, the azquotamaster.sh needs to be modified as follows: <br/>

Step b.1:
Enter the regions for which the quota information is to be fetched. Example as below: <br/>
regionarr=('southeastasia' 'eastus')

Step b.2:
Enter the AAD service principal details based on the output obtained in step a. Example as below: <br/>
./azquotaworker.sh "http://myspname" "my_sp_password" "tenant_id" "subscription_id" "${regionarr[@]}"

So in all the 2 lines should look as below: <br/>

regionarr=('region1' 'region2') <br/>
./azquotaworker.sh "<sp_name>" "<sp_password>" "<tenant_id>" "<subscription_id>" "${regionarr[@]}"


Repeat the above two lines with relevant details for fetching the quota information for different subscription ids.


Step c:
Make both the shell scripts executable (azquotamaster.sh and azquotaworker.sh)

Step d:
Execute the azquotamaster.sh script. Example below if the script is to be execute from the same folder: <br/>
./azquotamaster.sh


Step e:
The quota information is generated in the .csv files. The csv file naming will be of the format <Subscription_id>_<region>.csv
