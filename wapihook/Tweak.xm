//#define FAKE_CHINA

%hookf(Boolean, "_MGGetBoolAnswer", CFStringRef string)
{
	if (CFEqual(string, CFSTR("wapi")) || CFEqual(string, CFSTR("hiHut/WR+B9Lx/vd0WyeNg"))) {
#ifdef FAKE_CHINA
		return true;
#else
		return false;
#endif
	}
	return %orig;
}
