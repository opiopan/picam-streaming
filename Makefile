SERVICEDIR	= /etc/systemd/system
SHAREDIR	= /usr/share/picam-streaming
SERVICES	= picam-env.service picam-streaming.service picam-http.service

all:

install: $(SHAREDIR)
	cp -RL sbin html $(SHAREDIR)
	cp services/* $(SERVICEDIR)
	systemctl daemon-reload
	for s in $(SERVICES);do systemctl enable $$s || exit 1;done
	for s in $(SERVICES);do systemctl restart $$s || exit 1;done

uninstall:
	for s in $(SERVICES);do systemctl stop $$s || exit 1;done
	for s in $(SERVICES);do systemctl disable $$s || exit 1;done
	rm -rf $(SHAREDIR)
	for s in $(SERVICES);do rm -f $(SERVICEDIR)/$$s || exit 1;done
	systemctl daemon-reload

$(SHAREDIR):
	mkdir $@