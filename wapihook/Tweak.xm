//#define FAKE_CHINA

%hookf(CFBooleanRef, "_MGGetBoolAnswer", CFStringRef string)
{
	if (CFEqual(string, CFSTR("wapi")) || CFEqual(string, CFSTR("hiHut/WR+B9Lx/vd0WyeNg"))) {
#ifdef FAKE_CHINA
		return kCFBooleanTrue;
#else
		return kCFBooleanFalse;
#endif
	}
	return %orig;
}
