
GAME_SRC = \
	src/game/jawsjs.js \
	src/game/Block.js \
	src/game/Shapes.js \
	src/game/WallKicks.js \
	src/game/ControlGroup.js \
	src/game/Background.js \
	src/game/RandomBag.js \
	src/game/PreviewGroup.js \
	src/game/ScoreTracker.js \
	src/game/TtyBlock.js \
	src/game/Game.js \
	src/game/Game_Logic.js \
	src/game/Button.js \
	src/game/tetris.js \
	src/game/gameControls.js

STATIC_CONTENT = \
	src/js/json-minified.js \
	src/css/styles.css \
	src/js/scoreScreen.js \
	src/js/highScores.js \
	src/css/controlsStyles.css \
	src/game/jawsjs.js \
	src/js/input.js \
	src/js/controls.js \
	src/js/cookie.js

STATIC_CONTENT_EXPLICIT = \
	src/html/about.htm \
	src/html/scoreScreen.htm \
	src/html/highScores.htm \
	src/html/controls.htm

MEDIA = \
	media/blueblock.png \
	media/cyanblock.png \
	media/emptyblock.png \
	media/greenblock.png \
	media/greyblock.png \
	media/orangeblock.png \
	media/purpleblock.png \
	media/redblock.png \
	media/yellowblock.png \
	media/buttons/continue.png \
	media/buttons/restart.png \
	media/background/backdrop.png \
	media/background/endconsole.png \
	media/background/logo.png \
	media/background/topbar.png

DEBUG_HTML_SRC = \
	src/html/index.htm 

DEPLOY_HTML_SRC = \
	src/html/index_deploy.htm


WEB_APP_SRC = \
	src/webapp/app.yaml \
	src/webapp/tetris.py \
	src/webapp/highscore.py \
	src/webapp/index.yaml \
	src/webapp/cron.yaml \
	favicon.ico


debug: DIR = debug
debug: webApp gameUncompressed staticContent

release: DIR = deploy
release: webApp gameCompressed staticContent

webApp: $(WEB_APP_SRC)
	-rm -r $(DIR)
	mkdir $(DIR)
	cp $(WEB_APP_SRC) $(DIR)

gameUncompressed: $(GAME_SRC) $(DEBUG_HTML_SRC)
	mkdir $(DIR)/tetris
	cp $(GAME_SRC) $(DIR)/tetris
	cp src/html/index.htm $(DIR)/tetris/index.html

gameCompressed: $(GAME_SRC) $(DEPLOY_HTML_SRC)
	mkdir $(DIR)/tetris
	cat $(GAME_SRC) > $(DIR)/tetris/tetris_main_noop.js
	java -jar build/yuicompressor-2.4.6.jar $(DIR)/tetris/tetris_main_noop.js -o $(DIR)/tetris/tetris_main.js
	rm $(DIR)/tetris/tetris_main_noop.js
	cp src/html/index_deploy.htm $(DIR)/tetris/index.html

staticContent: $(STATIC_CONTENT) $(STATIC_CONTENT_EXXPLICIT) $(MEDIA)
	mkdir $(DIR)/tetris/media
	cp -r media/* $(DIR)/tetris/media
	cp $(STATIC_CONTENT) $(DIR)/tetris
	cp src/html/about.htm $(DIR)/tetris/about.html
	cp src/html/scoreScreen.htm $(DIR)/tetris/scoreScreen.html
	cp src/html/highScores.htm $(DIR)/tetris/highScores.html
	cp src/html/controls.htm $(DIR)/tetris/controls.html
