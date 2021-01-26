VERSION = $(shell git describe --tags --abbrev=0 | sed -r 's/^v//g')
PKGDIR = $(shell pwd)/pkg

all: private-tmpdir.so

private-tmpdir.so: private-tmpdir.c
	gcc -std=gnu99 -Wall -o private-tmpdir.o -fPIC -c private-tmpdir.c
	gcc -shared -o private-tmpdir.so private-tmpdir.o

clean:
	rm -f private-tmpdir.o private-tmpdir.so

package:
	mkdir -p $(PKGDIR)
	git ls-files | tar -c --transform 's,^,slurm-spank-private-tmpdir-$(VERSION)/,' -T - | gzip > $(PKGDIR)/slurm-spank-private-tmpdir-$(VERSION).tar.gz

