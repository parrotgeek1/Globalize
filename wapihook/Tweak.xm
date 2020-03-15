#import <substrate.h>

//#define FAKE_CHINA

static CFTypeRef (*orig_WiFiDeviceClientCopyProperty)(void *cl,CFStringRef key);
CFTypeRef replaced_WiFiDeviceClientCopyProperty(void *cl,CFStringRef key) {
	CFTypeRef retval = NULL;
	if (CFEqual(key, CFSTR("WAPIEnabled")))  {
#ifdef FAKE_CHINA
        	retval = CFSTR("1");
#else
        	retval = NULL;
#endif
	} else {
		retval = orig_WiFiDeviceClientCopyProperty( cl,key );
	}
	return retval;
}


__attribute__((constructor)) static void wapiinit() {
	void * WiFiDeviceClientCopyProperty=dlsym(RTLD_DEFAULT, "WiFiDeviceClientCopyProperty");
	MSHookFunction((void *)WiFiDeviceClientCopyProperty, (void *)replaced_WiFiDeviceClientCopyProperty, (void **)&orig_WiFiDeviceClientCopyProperty);
}
