include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Globalize
Globalize_FILES = Tweak.xm
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "ldrestart"
SUBPROJECTS += wapihook
SUBPROJECTS += pridewatchfacehook

include $(THEOS_MAKE_PATH)/aggregate.mk
