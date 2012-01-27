# Only applicable for OMAP4 and OMAP5 boards.
# First eliminate OMAP3 and then ensure that this is not used
# for customer boards
ifneq ($(TARGET_BOARD_PLATFORM),omap3)
ifeq ($(findstring omap, $(TARGET_BOARD_PLATFORM)),omap)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	delegation_client.c \
	delegation_client_extension.c \
	smc_properties.c \
	smc_properties_parser.c \
	lib_manifest2.c

LOCAL_LDFLAGS += -llog

LOCAL_CFLAGS += -DLINUX
LOCAL_CFLAGS += -D__ANDROID32__
LOCAL_CFLAGS += -DSUPPORT_DELEGATION_EXTENSION

ifdef S_VERSION_BUILD
LOCAL_CFLAGS += -DS_VERSION_BUILD=$(S_VERSION_BUILD)
endif

LOCAL_CFLAGS += -I $(LOCAL_PATH)/../tf_sdk/include/

LOCAL_MODULE:= tf_daemon
LOCAL_STATIC_LIBRARIES := libtee_client_api_driver
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)
endif
endif
