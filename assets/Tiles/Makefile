# Directories
SRC_DIR=src
BUILD_DIR=__build__

# Options
TERRAINS=Country

SET_GEOMETRY='64x64>+2+2'

# Targets
TERR_DIRS=$(foreach terr, $(TERRAINS), $(SRC_DIR)/$(terr))
TERR_BUILD_DIRS=$(foreach terr, $(TERRAINS), $(BUILD_DIR)/$(terr))
SVG=$(wildcard $(TERR_DIRS)/*.svg)

PNG=$(addprefix $(BUILD_DIR)/, $(SVG:$(SRC_DIR)/%.svg=%.png))

# Binaries
INKSCAPE=/Applications/Inkscape.app/Contents/Resources/bin/inkscape
MONTAGE=montage



###===================================================================###

.PHONY: all clean
all: $(TERRAINS).png $(PNG)

$(BUILD_DIR)/%.png: $(SRC_DIR)/%.svg
	@echo "Building PNG file: " $@
	@mkdir -p $(TERR_BUILD_DIRS) &> /dev/null
	@$(INKSCAPE) $< --export-png=$@ &> /dev/null

%.png: $(PNG)
	@echo "Creating tileset: " $@
	@$(MONTAGE) $^ -geometry $(SET_GEOMETRY) -background none $@

clean:
	@rm -rf $(BUILD_DIR) $(TERRAINS).png