GEN_SRC=\
	src/cap-awp-js.ts src/cap-worker-js.ts src/cap-worker-waiter-js.ts \
	src/play-awp-js.ts src/play-shared-awp-js.ts

SRC=\
	src/audio-bidir.js src/audio-capture.js src/audio-playback.js \
	src/events.js src/main.js src/util.js \
	\
	src/cap-awp-js.js src/cap-worker-js.js src/cap-worker-waiter-js.js \
	src/play-awp-js.js src/play-shared-awp-js.js

all: dist/weasound.js dist/weasound.min.js

dist/weasound.js: $(SRC) node_modules/.bin/tsc
	./node_modules/.bin/rollup -c

dist/weasound.min.js: dist/weasound.js node_modules/.bin/tsc
	true

%-js.ts: %.ts node_modules/.bin/tsc
	./node_modules/.bin/tsc --target es2017 --lib es2017,dom $< \
		--outFile $@.tmp
	./build-sourcemod.js < $@.tmp > $@
	rm -f $@.tmp

%.js: %.ts $(GEN_SRC) node_modules/.bin/tsc
	./node_modules/.bin/tsc --target es6 --lib es2015,dom \
		--moduleResolution node $<

node_modules/.bin/tsc:
	npm install

clean:
	rm -rf dist
	rm -f $(SRC) $(GEN_SRC)

.PRECIOUS: $(GEN_SRC)
