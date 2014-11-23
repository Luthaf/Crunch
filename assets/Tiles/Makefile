# Directories
SRC_DIR=src
BUILD_DIR=__build__

# Options
_TERRAINS_=Country Objects
TERRAINS=$(foreach terr, $(_TERRAINS_), $(terr).png)
SET_GEOMETRY='45x45>+0+0'

# Targets
TERR_BUILD_DIRS=$(foreach terr, $(_TERRAINS_), $(BUILD_DIR)/$(terr))
SVG=$(foreach terr, $(_TERRAINS_), $(wildcard $(SRC_DIR)/$(terr)/*.svg))

PNG=$(addprefix $(BUILD_DIR)/, $(SVG:$(SRC_DIR)/%.svg=%.png))

# Binaries
INKSCAPE=/Applications/Inkscape.app/Contents/Resources/bin/inkscape
MONTAGE=montage



###===================================================================###

.PHONY: all clean
all:$(TERRAINS)

.PRECIOUS:$(PNG)

$(BUILD_DIR)/%.png: $(SRC_DIR)/%.svg
	@echo "Building PNG file: " $@
	@mkdir -p $(TERR_BUILD_DIRS) &> /dev/null
	@$(INKSCAPE) $< --export-png=$@ &> /dev/null

%.png: $(PNG)
	@echo "Creating tileset: " $@
	@$(MONTAGE) $(BUILD_DIR)/$*/*.png -geometry $(SET_GEOMETRY) -background none $@

clean:
	@rm -rf $(BUILD_DIR) $(TERRAINS)