DEMO/ARCHIVE_CONTENTS := $(wildcard episodes/src/demo/**/*)

# Make the tar file from the `episodes/src/demo` directory
episodes/src/demo.tar.gz: $(DEMO/ARCHIVE_CONTENTS)
	tar -cvzf episodes/src/demo.tar.gz -C episodes/src demo