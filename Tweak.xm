#import <substrate.h>

typedef mach_port_t io_object_t;
typedef io_object_t io_registry_entry_t;
typedef UInt32 IOOptionBits;

//#define FAKE_CHINA

const uint32_t swbh[] = {1,0,0,0}; // only "valid"

static CFTypeRef (*orig_registryEntry)(io_registry_entry_t entry,  CFStringRef key, CFAllocatorRef allocator, IOOptionBits options);
CFTypeRef replaced_registryEntry(io_registry_entry_t entry,  CFStringRef key, CFAllocatorRef allocator, IOOptionBits options) {
	CFTypeRef retval = NULL;
	if (CFEqual(key, CFSTR("region-info"))) {
#ifdef FAKE_CHINA
		retval = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)"CH/A", 5);
#else
		retval = CFDataCreate(kCFAllocatorDefault, (const unsigned char *)"X/A", 4); // FIXME: use real /A /B part 
#endif

	} else if (CFEqual(key, CFSTR("software-behavior"))) {
		retval = CFDataCreate(kCFAllocatorDefault, (const UInt8 *)&swbh ,16);
   	} else {
        	retval = orig_registryEntry(entry, key, allocator, options);
	}
	return retval;
}

__attribute__((constructor)) static void regioninit() {
	void * IORegistryEntryCreateCFProperty=MSFindSymbol(MSGetImageByName("/System/Library/Frameworks/IOKit.framework/Versions/A/IOKit"), "_IORegistryEntryCreateCFProperty");
	MSHookFunction((void *)IORegistryEntryCreateCFProperty, (void *)replaced_registryEntry, (void **)&orig_registryEntry);
}
