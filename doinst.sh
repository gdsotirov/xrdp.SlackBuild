config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/rc.d/rc.xrdp.new
config etc/xrdp/km-0407.ini.new
config etc/xrdp/km-0409.ini.new
config etc/xrdp/km-040c.ini.new
config etc/xrdp/km-0410.ini.new
config etc/xrdp/km-0419.ini.new
config etc/xrdp/km-041d.ini.new
config etc/xrdp/rsakeys.ini.new
config etc/xrdp/sesman.ini.new
config etc/xrdp/xrdp.ini.new

