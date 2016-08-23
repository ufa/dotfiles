#incluindo o .bashrc
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d dias, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %R"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
  .~ .~~~..~.
  : .~.'~'.~. :   Uptime..............: ${UPTIME}
 ~ (   ) (   ) ~  Memória.............: `cat /proc/meminfo | grep MemAvailable | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
( : '~'.~.'~' : ) Carga média.........: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Processos ativos....: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   Endereço IP.........: `/sbin/ifconfig wlan0 | /bin/grep "inet addr" | /usr/bin/cut -d ":" -f 2 | /usr/bin/cut -d " " -f 1`
   '~ .~~~. ~'    Tempo...............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=SAM|BR|BR007|BRASILIA|" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
       '~'        Temperatura interna.: `sudo vcgencmd measure_temp | /usr/bin/cut -d "=" -f 2`
$(tput sgr0)"

#Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|UK|UK001|NAILSEA|" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'

#prompt colorido
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\]"
