GEN_SRC=\
	src/cap-awp-js.ts src/cap-worker-js.ts src/cap-worker-waiter-js.ts \
	src/play-awp-js.ts src/play-shared-awp-js.ts

all: dist/weasound.js dist/weasound.min.js

dist/weasound.js: src/*.ts $(GEN_SRC) node_modules/.bin/tsc
	./node_modules/.bin/rollup -c

dist/weasound.min.js: dist/weasound.js node_modules/.bin/tsc
	true

%-js.ts: %.ts node_modules/.bin/tsc
	./node_modules/.bin/tsc --strict --target es2017 --lib es2017,dom $< \
		--outFile $@.tmp
	./src/build-sourcemod.js < $@.tmp > $@
	rm -f $@.tmp

node_modules/.bin/tsc:
	npm install

clean:
	rm -rf dist
	rm -f $(GEN_SRC)

.PRECIOUS: $(GEN_SRC)
