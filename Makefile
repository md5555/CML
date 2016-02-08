TARGETS		:= $(sort $(patsubst %.cml,%,$(wildcard *.cml)))
GIT_BINARY 	:= git
GIT_PRE_ARGS	:= --work-tree=../ --git-dir=../.git
GIT_ARGS 	:= cherry-pick -x --allow-empty

all: $(TARGETS)

ifeq ($(CML_VERBOSE),)
      REDIRECT := >/dev/null 
else
      REDIRECT := 
endif

%: %.cml
	@@echo Processing CML: $(patsubst %.cml,%, $<) $(REDIRECT)
	@@for commit in `cat $<`; do \
		echo ...running $$commit $(REDIRECT); \
		$(GIT_BINARY) $(GIT_PRE_ARGS) $(GIT_ARGS) $$commit $(REDIRECT); \
	done 
