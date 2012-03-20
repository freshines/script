ALARM="/home/work/sn-index/script/alarm.sh"
function write_log()
{
    if [ $# -eq 1 ]
    then
	echo `date "+%Y-%m-%d %H:%M:%S" `" $1"
    fi
    return 0
}