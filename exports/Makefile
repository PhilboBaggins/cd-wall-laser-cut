
.PHONY: all clean

ALL := CDwall.stl CDwall.png CDwallCover2D.dxf CDwallCover2D.svg CDwallHolder2D.dxf CDwallHolder2D.svg

all: $(ALL)

CDwall.stl CDwall.png: CDwall.scad
	openscad -o $@ $<

CDwallCover2D.dxf CDwallCover2D.svg: CDwallCover2D.scad
	openscad -o $@ $<

CDwallHolder2D.dxf CDwallHolder2D.svg: CDwallHolder2D.scad
	openscad -o $@ $<

clean:
	rm -f $(ALL)
