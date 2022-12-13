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

# Keep same perms on rc.xrdp.new:
if [ -e etc/rc.d/rc.xrdp ]; then
  cp --archive etc/rc.d/rc.xrdp etc/rc.d/rc.xrdp.new.incoming
  cat etc/rc.d/rc.xrdp.new > etc/rc.d/rc.xrdp.new.incoming
  mv etc/rc.d/rc.xrdp.new.incoming etc/rc.d/rc.xrdp.new
fi

config etc/default/xrdp.new
config etc/pam.d/xrdp-sesman.new
config etc/rc.d/rc.xrdp.new
config etc/xrdp/km-00000406.ini.new
config etc/xrdp/km-00000407.ini.new
config etc/xrdp/km-00000409.ini.new
config etc/xrdp/km-0000040a.ini.new
config etc/xrdp/km-0000040b.ini.new
config etc/xrdp/km-0000040c.ini.new
config etc/xrdp/km-00000410.ini.new
config etc/xrdp/km-00000411.ini.new
config etc/xrdp/km-00000412.ini.new
config etc/xrdp/km-00000414.ini.new
config etc/xrdp/km-00000415.ini.new
config etc/xrdp/km-00000416.ini.new
config etc/xrdp/km-00000419.ini.new
config etc/xrdp/km-0000041d.ini.new
config etc/xrdp/km-00000807.ini.new
config etc/xrdp/km-00000809.ini.new
config etc/xrdp/km-0000080a.ini.new
config etc/xrdp/km-0000080c.ini.new
config etc/xrdp/km-00000813.ini.new
config etc/xrdp/km-00000816.ini.new
config etc/xrdp/km-0000100c.ini.new
config etc/xrdp/km-00010409.ini.new
config etc/xrdp/km-19360409.ini.new
config etc/xrdp/pulse/default.pa.new
config etc/xrdp/reconnectwm.sh.new
config etc/xrdp/sesman.ini.new
config etc/xrdp/startwm.sh.new
config etc/xrdp/xrdp.ini.new
config etc/xrdp/xrdp_keyboard.ini.new

# Generate security keys, certificate and key
# Based on keygen/Makefile.am
# See https://github.com/neutrinolabs/xrdp/blob/1c4e14415d923666ac60cb77c7e753ca24e0268d/keygen/Makefile.am#L20
umask 077 && \
if [ ! -f etc/xrdp/rsakeys.ini ]; then \
  /usr/bin/xrdp-keygen xrdp auto; \
fi && \
if [ ! -f etc/xrdp/cert.pem ]; then \
  /usr/bin/openssl req -x509 -newkey rsa:2048 -sha256 -nodes \
  -keyout etc/xrdp/key.pem -out etc/xrdp/cert.pem -days 365 \
  -subj /C=US/ST=CA/L=Sunnyvale/O=xrdp/CN=www.xrdp.org \
  -config /etc/ssl/openssl.cnf; \
fi

