#!/bin/bash

DESTDIR=/
NAME=proxmox-backup-client-$VERSION
BINARIES=( /src/proxmox-backup/target/release/{dump-catalog-shell-cli,pxar,proxmox-backup-client} )

mkdir -p "$DESTDIR/$NAME" "$DESTDIR/$NAME/lib"

cp -v ${BINARIES[@]} "$DESTDIR/$NAME"
ldd ${BINARIES[@]} | grep "=> /" | awk '{print $3}' | sort -u | xargs -I '{}' cp -v '{}' "$DESTDIR/$NAME/lib"
cp /lib/ld-linux-* "$DESTDIR/$NAME/lib"

cp -v /scripts/client/* "$DESTDIR/$NAME"

cd $DESTDIR
tar zcfv "$NAME.tgz" $NAME
