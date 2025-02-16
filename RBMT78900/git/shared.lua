-- Constants

APP_REPO = "HarommelRabbid" 
APP_PROJECT = "RabbidMultiToolVita" 
APP_VPK = "RBMT78900" 

APP_VERSION_MAJOR = 0x00 -- major.minor
APP_VERSION_MINOR = 0x11

APP_VERSION = ((APP_VERSION_MAJOR << 0x18) | (APP_VERSION_MINOR << 0x10)) -- Union Binary - what the fuck is a union binary
