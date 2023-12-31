SRC=\
	src/*.ts src/cap-awp-js.ts src/cap-worker-js.ts \
	src/cap-worker-waiter-js.ts src/play-awp-js.ts \
	src/play-shared-awp-js.ts

all: weasound.js weasound.min.js

weasound.js: $(SRC) node_modules/.bin/browserify
	./src/build.js | cat src/license.js - > $@

weasound.min.js: weasound.js node_modules/.bin/browserify
	./node_modules/.bin/uglifyjs -m < $< | cat src/license.js - > $@

%-js.ts: %.ts node_modules/.bin/browserify
	./node_modules/.bin/tsc --target es2017 --lib es2017,dom $< \
		--outFile $@.tmp
	./src/build-sourcemod.js < $@.tmp > $@
	rm -f $@.tmp

node_modules/.bin/browserify:
	npm install

clean:
	rm -f weasound.js weasound.min.js src/*-js.ts
