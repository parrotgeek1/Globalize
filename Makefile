include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Globalize
Globalize_FILES = Tweak.xm
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += wapihook
SUBPROJECTS += pridewatchfacehook
#SUBPROJECTS += taiwanflaghook
#SUBPROJECTS += taiwanflaghookui
include $(THEOS_MAKE_PATH)/aggregate.mk
