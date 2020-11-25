include WINDOWS.inc

include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

comment #
typedef struct _MEMORYSTATUS {
  DWORD  dwLength;
  DWORD  dwMemoryLoad;
  SIZE_T dwTotalPhys;
  SIZE_T dwAvailPhys;
  SIZE_T dwTotalPageFile;
  SIZE_T dwAvailPageFile;
  SIZE_T dwTotalVirtual;
  SIZE_T dwAvailVirtual;
} MEMORYSTATUS, *LPMEMORYSTATUS;
#

.data
String     db    256 dup(0)
comment #
Format    db    "%u%% - Memory load", 0dh
      db    "%u bytes - Total memoty", 0dh
      db    "%u bytes - Free memoty", 0dh
      db    "%u bytes - Size of the committed memory limit", 0dh
      db    "%u bytes - Maximum amount of memory the current process can commit", 0dh
      db    "%u bytes - Size of the user-mode portion of the virtual address space of the calling process", 0dh
      db    "%u bytes - The amount of unreserved and uncommitted virtual memory", 0dh, 0
#
;comment #
Format    db    "%d%% - Memory load", 0dh
      db    "%d MB - Total memoty", 0dh
      db    "%d MB - Free memoty", 0dh
      db    "%d MB - Size of the committed memory limit", 0dh
      db    "%d MB - Maximum amount of memory the current process can commit", 0dh
      db    "%d MB - Size of the user-mode portion of the virtual address space of the calling process", 0dh
      db    "%d MB - The amount of unreserved and uncommitted virtual memory", 0dh, 0
;#
My_Title    db    "Memory", 0
memory     dd    ?

.data?
m MEMORYSTATUS <?>