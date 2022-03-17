# Makefile that uploades everything from $(HTDOCSDIR) to $(_SNAPSHOTDEST)

_DCFSNAPSHOTDIR=$(DCFHTDOCSDIR)/$(TARBALLBASE)
_DCFREGTESTDIR=$(DCFHTDOCSDIR)/$(REGTESTBASE)
_DCFCHANGELOGDIR=$(DCFHTDOCSDIR)/changelog_heads

# Location to copy the tarball to
_DCFSNAPSHOTDEST=$(DCFUSER)@$(DCFHOST):$(DCFHTDOCSDIR)

.PHONY: do-upload
do-upload:
	# copy files to the destination
	# make all files writable and searchable by group members on the destination
	# and remove them from source
	cd $(HTDOCSDIR); \
	DIR_LIST=`find * -type d -print 2>/dev/null`; \
	FILE_LIST=`find * -type f -print 2>/dev/null`; \
	if test -n "$$FILE_LIST"; \
	then \
	  echo "--- rsync upload started on `date` ---"; \
	  rsync --chmod=Dg+wx,Fg+w --perms --relative --include='*.exe' -e "ssh -p $(DCFPORT) -o StrictHostKeyChecking=no" --size-only $$FILE_LIST $(_DCFSNAPSHOTDEST) && \
	  { \
	    rm -rf $(HTDOCSDIR)/*; \
	  }; \
	  echo "--- rsync upload finished on `date` ---"; \
	fi
