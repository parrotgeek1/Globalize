#import <substrate.h>
//#define FAKE_CHINA

Boolean (*old_MGGetBoolAnswer)(CFStringRef);
Boolean replaced_MGGetBoolAnswer(CFStringRef string)
{
    if (CFEqual(string, CFSTR("wapi")) || CFEqual(string, CFSTR("hiHut/WR+B9Lx/vd0WyeNg"))) {
		#ifdef FAKE_CHINA
			return true;
		#else
			return false;
		#endif
	}
	return old_MGGetBoolAnswer(string);
}


%ctor
{
	MSHookFunction((void *)(dlsym(RTLD_DEFAULT, "MGGetBoolAnswer")), (void *)replaced_MGGetBoolAnswer, (void **)&old_MGGetBoolAnswer);
}
