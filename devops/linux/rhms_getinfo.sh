## To gather system resources metrics
## WriitenBy: Shrishti S
## Arguments passed: None


# System resources gathered as facts in variables
# ie: ip add,cpu,memory
get_host=`hostname`
get_ip=`ifconfig  enp0s8 | grep 'inet '| awk '{print $2}'`
get_mem=`free |grep Mem|awk '{print$4/$2*100"%"}'`
get_cpu=`grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'`
all_vars=`echo $get_host,$get_ip,$get_mem,$get_cpu`


# Display variable values for reference
echo $all_vars
echo $get_ip

# Connecting to RHMS Server
ssh   root@192.168.29.40 "

# find and deete if the host ip exists
sed -i '/$get_ip/d' /var/www/html/resource.csv

# fetches real time resources and insert into resource.csv
#(resource file is located in RHMS server)
echo "$get_host,$get_ip,$get_mem,$get_cpu" >> /var/www/html/resource.csv
"
